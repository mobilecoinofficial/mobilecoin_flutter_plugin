// Copyright (c) 2021-2026 MobileCoin. All rights reserved.

import Flutter
import Foundation
import MobileCoin

// Identity parsing rejects a malformed entry rather than dropping it. Dropping
// one cannot weaken trust -- evidence is only accepted against the identities
// that survive -- but it makes a misconfiguration invisible, leaving a typo to
// present as an enclave that never matches. Matches the Android bridge.
private func malformedIdentity(_ reason: String) -> MistysignAttestedSessionError {
    // Reuses the SDK's error so the Dart-visible code comes from the one
    // mapping in `flutterCode` and cannot drift from it.
    .attestationFailed(reason)
}

/// Splits the comma joined advisories the Dart side sends. An absent or empty
/// value means none.
private func mistysignAdvisories(_ value: Any?) -> [String] {
    (value as? String)?.split(separator: ",").map(String.init) ?? []
}

private func mistysignMeasurement(
    _ entry: [String: Any],
    _ key: String
) throws -> Data {
    guard let hex = entry[key] as? String else {
        throw malformedIdentity("Trusted identity is missing '\(key)'")
    }
    // HexEncoding rejects an odd length and any non-hex character, so a typo
    // cannot become a measurement that silently never matches.
    guard let measurement = HexEncoding.data(fromHexEncodedString: hex) else {
        throw malformedIdentity("'\(key)' is not hex encoded: \(hex)")
    }
    return measurement
}

private func mistysignUInt16(
    _ entry: [String: Any],
    _ key: String
) throws -> UInt16 {
    guard let value = entry[key] as? Int else {
        throw malformedIdentity("Trusted identity is missing '\(key)'")
    }
    guard let narrowed = UInt16(exactly: value) else {
        throw malformedIdentity("'\(key)' does not fit in an unsigned 16 bit value: \(value)")
    }
    return narrowed
}

private func mistysignMrEnclaves(from entries: [[String: Any]]) throws -> [Attestation.MrEnclave] {
    try entries.map { entry in
        let mrEnclave = try mistysignMeasurement(entry, "mrEnclave")
        do {
            return try Attestation.MrEnclave.make(
                mrEnclave: mrEnclave,
                allowedConfigAdvisories: mistysignAdvisories(entry["configAdvisories"]),
                allowedHardeningAdvisories: mistysignAdvisories(entry["hardeningAdvisories"])
            ).get()
        } catch {
            throw malformedIdentity("Invalid mrEnclave identity: \(error)")
        }
    }
}

private func mistysignMrSigners(from entries: [[String: Any]]) throws -> [Attestation.MrSigner] {
    try entries.map { entry in
        let mrSigner = try mistysignMeasurement(entry, "mrSigner")
        let productId = try mistysignUInt16(entry, "productId")
        let minimumSecurityVersion = try mistysignUInt16(entry, "minimumSecurityVersion")
        do {
            return try Attestation.MrSigner.make(
                mrSigner: mrSigner,
                productId: productId,
                minimumSecurityVersion: minimumSecurityVersion,
                allowedConfigAdvisories: mistysignAdvisories(entry["configAdvisories"]),
                allowedHardeningAdvisories: mistysignAdvisories(entry["hardeningAdvisories"])
            ).get()
        } catch {
            throw malformedIdentity("Invalid mrSigner identity: \(error)")
        }
    }
}

private extension MistysignAttestedSessionError {
    // Distinct codes let the Dart side discriminate the failure kind.
    var flutterCode: String {
        switch self {
        case .notAttested:
            return "MISTYSIGN_NOT_ATTESTED"
        case .noTrustedIdentities:
            return "MISTYSIGN_NO_TRUSTED_IDENTITIES"
        case .attestationFailed:
            return "MISTYSIGN_ATTESTATION_FAILED"
        case .encryptionFailed:
            return "MISTYSIGN_ENCRYPTION_FAILED"
        case .decryptionFailed:
            return "MISTYSIGN_DECRYPTION_FAILED"
        }
    }
}

struct FfiMistysignAttestedSession {
    struct Create: Command {
        func execute(args: [String: Any], result: @escaping FlutterResult) throws {
            let session = MistysignAttestedSession()
            let hash = ObjectIdentifier(session).hashValue
            ObjectStorage.addObject(session, forKey: hash)
            result(hash)
        }
    }

    struct AuthBeginRequestData: Command {
        func execute(args: [String: Any], result: @escaping FlutterResult) throws {
            guard
                let id = args["id"] as? Int,
                let session = ObjectStorage.objectForKey(id) as? MistysignAttestedSession,
                let responderId = args["responderId"] as? String,
                // The SDK treats the handshake as infallible and traps the
                // process on an empty responder id, so it cannot be let past.
                !responderId.isEmpty
            else {
                throw PluginError.invalidArguments
            }

            result(session.authBeginRequestData(responderId: responderId))
        }
    }

    struct AuthEnd: Command {
        func execute(args: [String: Any], result: @escaping FlutterResult) throws {
            guard
                let id = args["id"] as? Int,
                let session = ObjectStorage.objectForKey(id) as? MistysignAttestedSession,
                let authResponseData = args["authResponseData"] as? FlutterStandardTypedData,
                let mrEnclaveEntries = args["mrEnclaves"] as? [[String: Any]],
                let mrSignerEntries = args["mrSigners"] as? [[String: Any]]
            else {
                throw PluginError.invalidArguments
            }

            do {
                let attestation = Attestation(
                    mrEnclaves: try mistysignMrEnclaves(from: mrEnclaveEntries),
                    mrSigners: try mistysignMrSigners(from: mrSignerEntries)
                )
                try session.authEnd(authResponseData: authResponseData.data, attestation: attestation)
                result(nil)
            } catch let error as MistysignAttestedSessionError {
                result(FlutterError(code: error.flutterCode, message: error.localizedDescription, details: nil))
            }
        }
    }

    struct Encrypt: Command {
        func execute(args: [String: Any], result: @escaping FlutterResult) throws {
            guard
                let id = args["id"] as? Int,
                let session = ObjectStorage.objectForKey(id) as? MistysignAttestedSession,
                let plaintext = args["plaintext"] as? FlutterStandardTypedData
            else {
                throw PluginError.invalidArguments
            }

            do {
                result(try session.encrypt(plaintext.data))
            } catch let error as MistysignAttestedSessionError {
                result(FlutterError(code: error.flutterCode, message: error.localizedDescription, details: nil))
            }
        }
    }

    struct Decrypt: Command {
        func execute(args: [String: Any], result: @escaping FlutterResult) throws {
            guard
                let id = args["id"] as? Int,
                let session = ObjectStorage.objectForKey(id) as? MistysignAttestedSession,
                let messageData = args["messageData"] as? FlutterStandardTypedData
            else {
                throw PluginError.invalidArguments
            }

            do {
                result(try session.decrypt(messageData.data))
            } catch let error as MistysignAttestedSessionError {
                result(FlutterError(code: error.flutterCode, message: error.localizedDescription, details: nil))
            }
        }
    }

    struct Deattest: Command {
        func execute(args: [String: Any], result: @escaping FlutterResult) throws {
            guard
                let id = args["id"] as? Int,
                let session = ObjectStorage.objectForKey(id) as? MistysignAttestedSession
            else {
                throw PluginError.invalidArguments
            }

            session.deattest()
            result(nil)
        }
    }

    struct IsAttested: Command {
        func execute(args: [String: Any], result: @escaping FlutterResult) throws {
            guard
                let id = args["id"] as? Int,
                let session = ObjectStorage.objectForKey(id) as? MistysignAttestedSession
            else {
                throw PluginError.invalidArguments
            }

            result(session.isAttested)
        }
    }

    struct Destroy: Command {
        func execute(args: [String: Any], result: @escaping FlutterResult) throws {
            guard let id = args["id"] as? Int else {
                throw PluginError.invalidArguments
            }

            try ObjectStorage.removeObject(forKey: id, ofType: MistysignAttestedSession.self)
            result(nil)
        }
    }
}
