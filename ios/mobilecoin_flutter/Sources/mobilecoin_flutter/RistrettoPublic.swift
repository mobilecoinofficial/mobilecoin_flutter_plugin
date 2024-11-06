//
//  RistrettoPublic.swift
//  mobilecoin_flutter
//
//  Created by Alexander Voloshyn on 9/29/20.
//

import Flutter
import Foundation
import MobileCoin

struct FfiRistrettoPublic {
    struct FromBytes: Command {
        func execute(args: [String : Any], result: @escaping FlutterResult) throws {
            guard let serializedBytes = args["serializedBytes"] as? FlutterStandardTypedData else {
                throw PluginError.invalidArguments
            }
            if let privateKey: WrappedRistrettoPublic = WrappedRistrettoPublic(serializedBytes.data) {
                let hashCode: Int = privateKey.hashValue
                ObjectStorage.addObject(privateKey, forKey: hashCode)
                result(hashCode)
            } else {
                result(FlutterError(code: "NATIVE", message: "Unable to create a WrappedRistrettoPublic from the provided data", details: nil))
            }
        }
    }
    struct ToByteArray: Command {
        func execute(args: [String : Any], result: @escaping FlutterResult) throws {
            guard let addressId: Int = args["id"] as? Int,
                  let privateKey: WrappedRistrettoPublic = ObjectStorage.objectForKey(addressId) as? WrappedRistrettoPublic else {
                      throw PluginError.invalidArguments
                  }
            result(privateKey.data)
        }
    }
}


