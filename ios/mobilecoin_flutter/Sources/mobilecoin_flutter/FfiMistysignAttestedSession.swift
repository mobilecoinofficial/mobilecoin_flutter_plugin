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

/// Splits the comma joined advisories the Dart side sends.
///
/// An absent value means none. A present one has to be the string the channel
/// contract specifies: reading no advisories out of a malformed value would
/// quietly narrow what the identity tolerates, so an enclave that legitimately
/// carries them would stop attesting with nothing to point at.
private func mistysignAdvisories(_ entry: [String: Any], _ key: String) throws -> [String] {
    guard let value = entry[key] else {
        return []
    }
    guard let joined = value as? String else {
        throw malformedIdentity("'\(key)' is not a comma joined string: \(type(of: value))")
    }
    return joined.split(separator: ",").map(String.init)
}

private func mistysignMeasurement(
    _ entry: [String: Any],
    _ key: String
) throws -> Data {
    guard let value = entry[key] else {
        throw malformedIdentity("Trusted identity is missing '\(key)'")
    }
    guard let hex = value as? String else {
        throw malformedIdentity("'\(key)' is not a hex encoded string: \(type(of: value))")
    }
    // HexEncoding rejects an odd length and any non-hex character, so a typo
    // cannot become a measurement that silently never matches.
    guard let measurement = HexEncoding.data(fromHexEncodedString: hex) else {
        throw malformedIdentity("'\(key)' is not a whole number of hex encoded bytes: \(hex)")
    }
    return measurement
}

private func mistysignUInt16(
    _ entry: [String: Any],
    _ key: String
) throws -> UInt16 {
    guard let value = entry[key] else {
        throw malformedIdentity("Trusted identity is missing '\(key)'")
    }
    guard let number = value as? Int else {
        throw malformedIdentity("'\(key)' is not an integer: \(type(of: value))")
    }
    guard let narrowed = UInt16(exactly: number) else {
        throw malformedIdentity("'\(key)' does not fit in an unsigned 16 bit value: \(number)")
    }
    return narrowed
}

private func mistysignMrEnclaves(from entries: [[String: Any]]) throws -> [Attestation.MrEnclave] {
    try entries.map { entry in
        let mrEnclave = try mistysignMeasurement(entry, "mrEnclave")
        // Read outside the do block: its catch is scoped to what `make` rejects,
        // and would otherwise restate a malformed advisory as an invalid identity.
        let config = try mistysignAdvisories(entry, "configAdvisories")
        let hardening = try mistysignAdvisories(entry, "hardeningAdvisories")
        do {
            return try Attestation.MrEnclave.make(
                mrEnclave: mrEnclave,
                allowedConfigAdvisories: config,
                allowedHardeningAdvisories: hardening
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
        let config = try mistysignAdvisories(entry, "configAdvisories")
        let hardening = try mistysignAdvisories(entry, "hardeningAdvisories")
        do {
            return try Attestation.MrSigner.make(
                mrSigner: mrSigner,
                productId: productId,
                minimumSecurityVersion: minimumSecurityVersion,
                allowedConfigAdvisories: config,
                allowedHardeningAdvisories: hardening
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
                let attestation = try Attestation(
                    mrEnclaves: mistysignMrEnclaves(from: mrEnclaveEntries),
                    mrSigners: mistysignMrSigners(from: mrSignerEntries)
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
