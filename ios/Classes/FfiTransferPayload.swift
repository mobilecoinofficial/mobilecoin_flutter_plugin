//
//  FfiTransferPayload.swift
//  mobilecoin_flutter
//
//  Created by Alexander Voloshyn on 9/29/20.
//

import Foundation
import MobileCoin

struct FfiTransferPayload {
    
    struct GetBip39Entropy: Command {
        func execute(args: [String : Any], result: @escaping FlutterResult) throws {
            guard let payloadId: Int = args["id"] as? Int,
                  let transferPayload = ObjectStorage.objectForKey(payloadId) as? TransferPayload else {
                      throw PluginError.invalidArguments
                  }
            result(transferPayload.bip39)
        }
    }
    
    struct GetMemo: Command {
        func execute(args: [String : Any], result: @escaping FlutterResult) throws {
            guard let payloadId: Int = args["id"] as? Int,
                  let transferPayload = ObjectStorage.objectForKey(payloadId) as? TransferPayload else {
                      throw PluginError.invalidArguments
                  }
            result(transferPayload.memo)
        }
    }
    
    struct GetPublicKey: Command {
        func execute(args: [String : Any], result: @escaping FlutterResult) throws {
            guard let payloadId: Int = args["id"] as? Int,
                  let transferPayload = ObjectStorage.objectForKey(payloadId) as? TransferPayload else {
                      throw PluginError.invalidArguments
                  }
            let hashCode = transferPayload.hashValue
            result(hashCode)
        }
    }
}
