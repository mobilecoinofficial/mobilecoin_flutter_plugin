//
//  FfiMistyswap.swift
//  mobilecoin_flutter
//
//  Created by Adam Mork 05/18/23
//

import Foundation
import MobileCoin
import LibMobileCoin

struct FfiMistyswap {
    struct InitiateOfframp: Command {
        func execute(args: [String: Any], result: @escaping FlutterResult) throws {
            guard 
                let mixinCredentialsJSON = args["mixinCredentialsJSON"] as? String,
                let srcAssetID = args["srcAssetID"] as? String,
                let srcExpectedAmount = args["srcExpectedAmount"] as? String,
                let dstAssetID = args["dstAssetID"] as? String,
                let dstAddress = args["dstAddress"] as? String,
                let dstAddressTag = args["dstAddressTag"] as? String,
                let minDstReceivedAmount = args["minDstReceivedAmount"] as? String,
                let maxFeeAmountInDstTokens = args["maxFeeAmountInDstTokens"] as? String,
                let clientId: Int = args["id"] as? Int,
                let client = ObjectStorage.objectForKey(clientId) as? MobileCoinClient
            else {
                result(FlutterError(code: "NATIVE", message: "InitiateOfframp", details: "parsing arguments"))
                throw PluginError.invalidArguments
            }

            client.initiateOfframp(
                mixinCredentialsJSON: mixinCredentialsJSON,
                srcAssetID: srcAssetID,
                srcExpectedAmount: srcExpectedAmount,
                dstAssetID: dstAssetID,
                dstAddress: dstAddress,
                dstAddressTag: dstAddressTag,
                minDstReceivedAmount: minDstReceivedAmount,
                maxFeeAmountInDstTokens: maxFeeAmountInDstTokens
            ) { (clientResult: Result<Data, MistyswapError>) in

                switch clientResult {
                case .success(let response):
                    DispatchQueue.main.async {
                        result(response)
                    }
                case .failure(let error):
                    result(FlutterError(code: "NATIVE", message: error.localizedDescription, details: "Mistyswap.initiateOfframp"))
                }
            }
        }
    }

    struct GetOfframpStatus: Command {
        func execute(args: [String: Any], result: @escaping FlutterResult) throws {
            guard 
                let offrampID = args["offrampID"] as? FlutterStandardTypedData,
                let clientId: Int = args["id"] as? Int,
                let client = ObjectStorage.objectForKey(clientId) as? MobileCoinClient
            else {
                result(FlutterError(code: "NATIVE", message: "GetOfframpID", details: "parsing arguments"))
                throw PluginError.invalidArguments
            }

            client.getOfframpStatus(
                offrampID: offrampID.data
            ) { (clientResult: Result<Data, MistyswapError>) in

                switch clientResult {
                case .success(let response):
                    DispatchQueue.main.async {
                        result(response)
                    }
                case .failure(let error):
                    result(FlutterError(code: "NATIVE", message: error.localizedDescription, details: "Mistyswap.getOfframpStatus"))
                }
            }
        }
    }

    struct ForgetOfframp: Command {
        func execute(args: [String: Any], result: @escaping FlutterResult) throws {
            guard 
                let offrampID = args["offrampID"] as? FlutterStandardTypedData,
                let clientId: Int = args["id"] as? Int,
                let client = ObjectStorage.objectForKey(clientId) as? MobileCoinClient
            else {
                result(FlutterError(code: "NATIVE", message: "ForgetOfframp", details: "parsing arguments"))
                throw PluginError.invalidArguments
            }

            client.forgetOfframp(
                offrampID: offrampID.data
            ) { (clientResult: Result<Data, MistyswapError>) in

                switch clientResult {
                case .success(let response):
                    DispatchQueue.main.async {
                        result(response)
                    }
                case .failure(let error):
                    result(FlutterError(code: "NATIVE", message: error.localizedDescription, details: "Mistyswap.forgetOfframpStatus"))
                }
            }
        }
    }
}

