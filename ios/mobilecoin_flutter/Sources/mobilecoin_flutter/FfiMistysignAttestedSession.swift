// Copyright (c) 2021-2026 MobileCoin. All rights reserved.

import Flutter
import Foundation
import MobileCoin

private func mistysignMrEnclaves(from entries: [[String: Any]]) -> [Attestation.MrEnclave] {
    entries.compactMap { entry in
        guard
            let hex = entry["mrEnclave"] as? String,
            let mrEnclave = HexEncoding.data(fromHexEncodedString: hex)
        else {
            return nil
        }
        let hardening = (entry["hardeningAdvisories"] as? String)?
            .split(separator: ",").map(String.init) ?? []
        let config = (entry["configAdvisories"] as? String)?
            .split(separator: ",").map(String.init) ?? []
        return try? Attestation.MrEnclave.make(
            mrEnclave: mrEnclave,
            allowedConfigAdvisories: config,
            allowedHardeningAdvisories: hardening
        ).get()
    }
}

private func mistysignMrSigners(from entries: [[String: Any]]) -> [Attestation.MrSigner] {
    entries.compactMap { entry in
        guard
            let hex = entry["mrSigner"] as? String,
            let mrSigner = HexEncoding.data(fromHexEncodedString: hex),
            let productIdArg = entry["productId"] as? Int,
            let minimumSecurityVersionArg = entry["minimumSecurityVersion"] as? Int,
            let productId = UInt16(exactly: productIdArg),
            let minimumSecurityVersion = UInt16(exactly: minimumSecurityVersionArg)
        else {
            return nil
        }
        let hardening = (entry["hardeningAdvisories"] as? String)?
            .split(separator: ",").map(String.init) ?? []
        let config = (entry["configAdvisories"] as? String)?
            .split(separator: ",").map(String.init) ?? []
        return try? Attestation.MrSigner.make(
            mrSigner: mrSigner,
            productId: productId,
            minimumSecurityVersion: minimumSecurityVersion,
            allowedConfigAdvisories: config,
            allowedHardeningAdvisories: hardening
        ).get()
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

            let attestation = Attestation(
                mrEnclaves: mistysignMrEnclaves(from: mrEnclaveEntries),
                mrSigners: mistysignMrSigners(from: mrSignerEntries)
            )

            do {
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
