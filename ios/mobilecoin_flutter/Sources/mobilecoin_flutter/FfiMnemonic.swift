//
//  FfiAccountKey.swift
//  mobilecoin_flutter
//
//  Created by Alexander Voloshyn on 9/29/20.
//

import Flutter
import Foundation
import MobileCoin

struct FfiMnemonic {
    struct FromBip39Entropy: Command {
        func execute(args: [String: Any], result: @escaping FlutterResult) throws {
            let entropy = args["bip39Entropy"] as! FlutterStandardTypedData;
            let mnemonicPhrase = Mnemonic.mnemonic(fromEntropy: entropy.data)
            switch mnemonicPhrase {
            case .success(let mnemonicPhrase):
                result(mnemonicPhrase)
            case .failure(let error):
                throw error
            }
        }
    }

    struct ToBip39Entropy: Command {
        func execute(args: [String : Any], result: @escaping FlutterResult) throws {
            let mnemonicPhrase = args["mnemonicPhrase"] as! String;
            let entropy = Mnemonic.entropy(fromMnemonic: mnemonicPhrase)
            switch entropy {
            case .success(let entropy):
                result(entropy)
            case .failure(let error):
                throw error
            }
        }
    }

    struct AllWords: Command {
        func execute(args: [String : Any], result: @escaping FlutterResult) throws {
            result(Mnemonic.allWords.joined(separator: ","))
        }
    }

}

