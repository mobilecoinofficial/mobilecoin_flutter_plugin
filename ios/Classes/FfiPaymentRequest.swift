//
//  FfiTransferPayload.swift
//  mobilecoin_flutter
//
//  Created by Alexander Voloshyn on 9/29/20.
//

import Foundation
import MobileCoin

struct FfiPaymentRequest {

    struct GetMemo: Command {
        func execute(args: [String : Any], result: @escaping FlutterResult) throws {
            let paymentRequestId: Int = args["id"] as! Int
            let paymentRequest = ObjectStorage.objectForKey(paymentRequestId) as! PaymentRequest
            result(paymentRequest.memo)
        }
    }
    
    struct GetValue: Command {
        func execute(args: [String : Any], result: @escaping FlutterResult) throws {
            let paymentRequestId: Int = args["id"] as! Int
            let paymentRequest = ObjectStorage.objectForKey(paymentRequestId) as! PaymentRequest
            result(String(paymentRequest.value ?? 0))
        }
    }

    struct GetPublicAddress: Command {
        func execute(args: [String : Any], result: @escaping FlutterResult) throws {
            let paymentRequestId: Int = args["id"] as! Int
            let paymentRequest = ObjectStorage.objectForKey(paymentRequestId) as! PaymentRequest
            
            let hashCode = paymentRequest.publicAddress.hashValue
            if (ObjectStorage.objectForKey(hashCode) == nil) {
                ObjectStorage.addObject(paymentRequest.publicAddress, forKey: hashCode)
            }
            result(hashCode)
        }
    }
}

