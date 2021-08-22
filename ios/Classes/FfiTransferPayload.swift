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
            let payloadId: Int = args["id"] as! Int
            let transferPayload = ObjectStorage.objectForKey(payloadId) as! TransferPayload
            // TODO: iOS SDK needs to add support for the bip39 entropy
            result(transferPayload.rootEntropy)
        }
    }
    
    struct GetMemo: Command {
        func execute(args: [String : Any], result: @escaping FlutterResult) throws {
            let payloadId: Int = args["id"] as! Int
            let transferPayload = ObjectStorage.objectForKey(payloadId) as! TransferPayload
            result(transferPayload.memo)
        }
    }

    struct GetPublicKey: Command {
        func execute(args: [String : Any], result: @escaping FlutterResult) throws {
            let payloadId: Int = args["id"] as! Int
            let transferPayload = ObjectStorage.objectForKey(payloadId) as! TransferPayload
            let hashCode = transferPayload.hashValue
            result(hashCode)
        }
    }
}

