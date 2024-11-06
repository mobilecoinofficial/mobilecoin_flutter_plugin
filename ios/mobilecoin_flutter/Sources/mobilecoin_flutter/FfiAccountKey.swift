//
//  FfiAccountKey.swift
//  mobilecoin_flutter
//
//  Created by Alexander Voloshyn on 9/29/20.
//

import Flutter
import Foundation
import MobileCoin

struct FfiAccountKey {
    struct FromBip39Entropy: Command {
        func execute(args: [String: Any], result: @escaping FlutterResult) throws {
            guard let entropy = args["bip39Entropy"] as? FlutterStandardTypedData,
                  let fogReportUri: String = args["fogReportUri"] as? String,
                  let fogAuthoritySpki = args["fogAuthoritySpki"] as? FlutterStandardTypedData,
                  let reportId: String = args["reportId"] as? String else {
                      throw PluginError.invalidArguments
                  }
            let accountKey = AccountKey.make(entropy: entropy.data, fogReportUrl: fogReportUri, fogReportId: reportId, fogAuthoritySpki: fogAuthoritySpki.data,  accountIndex: 0)
            switch accountKey {
            case .success(let accountKey):
                let hash = accountKey.hashValue
                ObjectStorage.addObject(accountKey, forKey: hash)
                result(hash)
            case .failure(let error):
                throw error
            }
        }
    }
    struct GetPublicAddress: Command {
        func execute(args: [String : Any], result: @escaping FlutterResult) throws {
            guard let addressId: Int = args["id"] as? Int else {
                throw PluginError.invalidArguments
            }
            let accountKey: AccountKey = ObjectStorage.objectForKey(addressId) as! AccountKey
            let publicAddress: PublicAddress = accountKey.publicAddress
            let hashCode = publicAddress.hashValue
            ObjectStorage.addObject(publicAddress, forKey: hashCode)
            result(hashCode)
        }
    }
}

