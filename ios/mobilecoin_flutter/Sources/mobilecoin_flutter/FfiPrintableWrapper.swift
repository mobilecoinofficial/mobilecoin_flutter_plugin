//
//  FfiPrintableWrapper.swift
//  mobilecoin_flutter
//
//  Created by Alexander Voloshyn on 9/29/20.
//

import Flutter
import Foundation
import MobileCoin

struct FfiPrintableWrapper{
    struct FromB58String: Command {
        func execute(args: [String : Any], result: @escaping FlutterResult) throws {
            guard let b58String: String = args["b58String"] as? String else {
                throw PluginError.invalidArguments
            }
            let decoded = Base58Coder.decode(b58String)
            switch decoded {
            case .publicAddress(let publicAddress):
                let hashCode: Int = publicAddress.hashValue
                ObjectStorage.addObject(publicAddress, forKey: hashCode)
                result(hashCode)
                break;
            case .transferPayload(let transferPayload):
                let hashCode: Int = transferPayload.hashValue
                ObjectStorage.addObject(transferPayload, forKey: hashCode)
                result(hashCode)
                break;
            case .paymentRequest(let paymentRequest):
                let hashCode: Int = paymentRequest.hashValue
                ObjectStorage.addObject(paymentRequest, forKey: hashCode)
                result(hashCode)
                break;
            default:
                throw PluginError.unimplemented
            }
        }
    }
    struct ToB58String: Command {
        func execute(args: [String : Any], result: @escaping FlutterResult) throws {
            guard let id: Int = args["id"] as? Int,
                  let obj = ObjectStorage.objectForKey(id) else {
                      throw PluginError.invalidArguments
                  }
            if let publicAddress = obj as? PublicAddress {
                let b58String = Base58Coder.encode(publicAddress)
                result(b58String)
            } else if let transferPayload = obj as? TransferPayload {
                let b58String = Base58Coder.encode(transferPayload)
                result(b58String)
            } else if let paymentRequest = obj as? PaymentRequest {
                let b58String = Base58Coder.encode(paymentRequest)
                result(b58String)
            } else {
                throw PluginError.unimplemented
            }
        }
    }
    struct FromPublicAddress: Command {
        func execute(args: [String : Any], result: @escaping FlutterResult) throws {
            if let id: Int = args["id"] as? Int {
                result(id)
            } else {
                throw PluginError.invalidArguments
            }
            
        }
    }
    struct HasPublicAddress: Command {
        func execute(args: [String : Any], result: @escaping FlutterResult) throws {
            guard let id: Int = args["id"] as? Int else {
                throw PluginError.invalidArguments
            }
            if let _ = ObjectStorage.objectForKey(id) as? PublicAddress {
                result(true)
            } else {
                result(false)
            }
        }
    }
    struct GetPublicAddress: Command {
        func execute(args: [String : Any], result: @escaping FlutterResult) throws {
            guard let id: Int = args["id"] as? Int else {
                throw PluginError.invalidArguments
            }
            if let _ = ObjectStorage.objectForKey(id) as? PublicAddress {
                result(id)
            } else {
                throw PluginError.notFound
            }
        }
    }
    struct FromTransferPayload: Command {
        func execute(args: [String : Any], result: @escaping FlutterResult) throws {
            guard let id: Int = args["id"] as? Int else {
                throw PluginError.invalidArguments
            }
            result(id)
        }
    }
    struct HasTransferPayload: Command {
        func execute(args: [String : Any], result: @escaping FlutterResult) throws {
            guard let id: Int = args["id"] as? Int else {
                throw PluginError.invalidArguments
            }
            if let _ = ObjectStorage.objectForKey(id) as? TransferPayload {
                result(true)
            } else {
                result(false)
            }
        }
    }
    struct GetTransferPayload: Command {
        func execute(args: [String : Any], result: @escaping FlutterResult) throws {
            guard let id: Int = args["id"] as? Int else {
                throw PluginError.invalidArguments
            }
            if let _ = ObjectStorage.objectForKey(id) as? TransferPayload {
                result(id)
            } else {
                throw PluginError.notFound
            }
        }
    }
    struct FromPaymentRequest: Command {
        func execute(args: [String : Any], result: @escaping FlutterResult) throws {
            guard let id: Int = args["id"] as? Int else {
                throw PluginError.invalidArguments
            }
            result(id)
        }
    }
    struct HasPaymentRequest: Command {
        func execute(args: [String : Any], result: @escaping FlutterResult) throws {
            guard let id: Int = args["id"] as? Int else {
                throw PluginError.invalidArguments
            }
            if let _ = ObjectStorage.objectForKey(id) as? PaymentRequest {
                result(true)
            } else {
                result(false)
            }
        }
    }
    struct GetPaymentRequest: Command {
        func execute(args: [String : Any], result: @escaping FlutterResult) throws {
            guard let id: Int = args["id"] as? Int else {
                throw PluginError.invalidArguments
            }
            if let _ = ObjectStorage.objectForKey(id) as? PaymentRequest {
                result(id)
            } else {
                throw PluginError.notFound
            }
        }
    }
}


