import Foundation
import MobileCoin

struct FfiCryptoBox {
    struct encrypt: Command {
        func execute(args: [String: Any], result: @escaping FlutterResult) throws {
            guard let data = args["data"] as? FlutterStandardTypedData,
                  let publicAddressId = args["publicAddressId"] as? Int else {
                      throw PluginError.invalidArguments
                  }
            let publicAddress: PublicAddress = ObjectStorage.objectForKey(publicAddressId) as! PublicAddress
            let ciphertextResult = DefaultCryptoBox.encrypt(
                plaintext: data.data,
                publicAddress: publicAddress
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
                  let accountKeyId = args["accountKeyId"] as? Int else {
                      throw PluginError.invalidArguments
                  }
            let accountKey: AccountKey = ObjectStorage.objectForKey(accountKeyId) as! AccountKey
            let plaintextResult = try DefaultCryptoBox.decrypt(
                ciphertext: ciphertext.data,
                accountKey: accountKey
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

