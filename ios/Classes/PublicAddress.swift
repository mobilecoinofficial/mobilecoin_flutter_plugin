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
            let serializedBytes = args["serializedBytes"] as! FlutterStandardTypedData;
            let publicAddress: PublicAddress = try! PublicAddress(serializedData: serializedBytes.data)! 
            let hashCode: Int = publicAddress.hashValue
            ObjectStorage.addObject(publicAddress, forKey: hashCode)
            result(hashCode)
        }
    }
    struct ToByteArray: Command {
        func execute(args: [String : Any], result: @escaping FlutterResult) throws {
            let addressId: Int = args["id"] as! Int
            let publicAddress: PublicAddress = ObjectStorage.objectForKey(addressId) as! PublicAddress
            result(publicAddress.serializedData)
        }
    }
}


