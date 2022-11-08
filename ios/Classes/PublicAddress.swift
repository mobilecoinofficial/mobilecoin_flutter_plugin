//
//  PublicAddress.swift
//  mobilecoin_flutter
//
//  Created by Alexander Voloshyn on 9/29/20.
//

import Foundation
import MobileCoin

struct FfiPublicAddress {
    struct FromBytes: Command {
        func execute(args: [String : Any], result: @escaping FlutterResult) throws {
            guard let serializedBytes = args["serializedBytes"] as? FlutterStandardTypedData else {
                throw PluginError.invalidArguments
            }
            if let publicAddress: PublicAddress = PublicAddress(serializedData: serializedBytes.data) {
                let hashCode: Int = publicAddress.hashValue
                ObjectStorage.addObject(publicAddress, forKey: hashCode)
                result(hashCode)
            } else {
                result(FlutterError(code: "NATIVE", message: "Unable to create a PublicAddress from the provided data", details: nil))
            }
        }
    }
    struct ToByteArray: Command {
        func execute(args: [String : Any], result: @escaping FlutterResult) throws {
            guard let addressId: Int = args["id"] as? Int,
                  let publicAddress: PublicAddress = ObjectStorage.objectForKey(addressId) as? PublicAddress else {
                      throw PluginError.invalidArguments
                  }
            result(publicAddress.serializedData)
        }
    }
    struct GetAddressHash: Command {
        func execute(args: [String : Any], result: @escaping FlutterResult) throws {
            guard let addressId: Int = args["id"] as? Int,
                  let publicAddress: PublicAddress = ObjectStorage.objectForKey(addressId) as? PublicAddress else {
                      throw PluginError.invalidArguments
                  }
            result(publicAddress.addressHash)
        }
    }
}


