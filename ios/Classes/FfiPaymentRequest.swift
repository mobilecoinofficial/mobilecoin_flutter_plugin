// Copyright (c) 2021-2024 MobileCoin. All rights reserved.

import Foundation
import MobileCoin

struct FfiPaymentRequest {
    
    struct Create: Command {
        func execute(args: [String : Any], result: @escaping FlutterResult) throws {
            guard let publicAddressId: Int = args["publicAddressId"] as? Int,
                  let tokenIdString = args["tokenId"] as? String,
                  let tokenID = UInt64(tokenIdString),
                  let publicAddress = ObjectStorage.objectForKey(publicAddressId) as? PublicAddress else {
                      throw PluginError.invalidArguments
                  }
            let paymentIdString = args["paymentId"] as? String
            let paymentId = UInt64(paymentIdString)
            let memo: String? = args["memo"] as? String
            let amount: String? = args["amount"] as? String
            let value: UInt64? = amount != nil ? UInt64(amount!) : nil
            let paymentRequest = PaymentRequest(publicAddress: publicAddress, value:value, memo: memo, tokenID: tokenID, paymentId: paymentId);
            let hashCode = paymentRequest.hashValue
            ObjectStorage.addObject(paymentRequest, forKey: hashCode)
            result(hashCode)
        }
    }
    
    struct GetMemo: Command {
        func execute(args: [String : Any], result: @escaping FlutterResult) throws {
            guard let objectId: Int = args["id"] as? Int,
                  let paymentRequest = ObjectStorage.objectForKey(objectId) as? PaymentRequest else {
                      throw PluginError.invalidArguments
                  }
            result(paymentRequest.memo)
        }
    }
    
    struct GetValue: Command {
        func execute(args: [String : Any], result: @escaping FlutterResult) throws {
            guard let objectId: Int = args["id"] as? Int,
                  let paymentRequest = ObjectStorage.objectForKey(objectId) as? PaymentRequest else {
                      throw PluginError.invalidArguments
                  }
            result(String(paymentRequest.value ?? 0))
        }
    }
    
    struct GetTokenId: Command {
        func execute(args: [String : Any], result: @escaping FlutterResult) throws {
            guard let objectId: Int = args["id"] as? Int,
                  let paymentRequest = ObjectStorage.objectForKey(objectId) as? PaymentRequest else {
                      throw PluginError.invalidArguments
                  }
            result(String(paymentRequest.tokenID))
        }
    }
    
    struct GetPublicAddress: Command {
        func execute(args: [String : Any], result: @escaping FlutterResult) throws {
            guard let objectId: Int = args["id"] as? Int,
                  let paymentRequest = ObjectStorage.objectForKey(objectId) as? PaymentRequest else {
                      throw PluginError.invalidArguments
                  }
            let hashCode = paymentRequest.publicAddress.hashValue
            if (ObjectStorage.objectForKey(hashCode) == nil) {
                ObjectStorage.addObject(paymentRequest.publicAddress, forKey: hashCode)
            }
            result(hashCode)
        }
    }
}

