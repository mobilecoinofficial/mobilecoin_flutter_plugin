import Flutter
import Foundation
import MobileCoin

struct FfiCryptoBox {
    struct encrypt: Command {
        func execute(args: [String: Any], result: @escaping FlutterResult) throws {
            guard let data = args["data"] as? FlutterStandardTypedData,
                  let publicKeyId = args["publicKeyId"] as? Int else {
                      throw PluginError.invalidArguments
                  }
            let publicKey: WrappedRistrettoPublic = ObjectStorage.objectForKey(publicKeyId) as! WrappedRistrettoPublic
            let ciphertextResult = DefaultCryptoBox.encrypt(
                plaintext: data.data,
                publicKey: publicKey
            )
            switch ciphertextResult {
                case .success(let ciphertext):
                    result(ciphertext)
                case .failure(let error):
                    throw error
            }
        }
    }

    struct decrypt: Command {
        func execute(args: [String : Any], result: @escaping FlutterResult) throws {
            guard let ciphertext = args["data"] as? FlutterStandardTypedData,
                  let privateKeyId = args["privateKeyId"] as? Int else {
                      throw PluginError.invalidArguments
                  }
            let privateKey: WrappedRistrettoPrivate = ObjectStorage.objectForKey(privateKeyId) as! WrappedRistrettoPrivate
            let plaintextResult = try DefaultCryptoBox.decrypt(
                ciphertext: ciphertext.data,
                privateKey: privateKey
            )
            switch plaintextResult {
                case .success(let plaintext):
                    result(plaintext)
                case .failure(let error):
                    throw error
            }
        }
    }
}

