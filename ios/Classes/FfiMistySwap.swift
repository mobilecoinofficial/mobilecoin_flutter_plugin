// Copyright (c) 2021-2024 MobileCoin. All rights reserved.

import Foundation
import MobileCoin
import LibMobileCoin

struct FfiMistyswap {
    struct InitiateOfframp: Command {
        func execute(args: [String: Any], result: @escaping FlutterResult) throws {
            guard 
                let bytes = args["initiateOfframpRequestBytes"] as? FlutterStandardTypedData,
                let proto = try? MistyswapOfframp_InitiateOfframpRequest.init(serializedData: bytes.data),
                let clientId: Int = args["mobileCoinClientId"] as? Int,
                let client = ObjectStorage.objectForKey(clientId) as? MobileCoinClient
            else {
                result(FlutterError(code: "NATIVE", message: "InitiateOfframp", details: "parsing arguments"))
                throw PluginError.invalidArguments
            }

            let mixinCredentialsJSON = proto.mixinCredentialsJson
            let srcAssetID = proto.params.srcAssetID
            let srcExpectedAmount = proto.params.srcExpectedAmount
            let dstAssetID = proto.params.dstAssetID
            let dstAddress = proto.params.dstAddress
            let dstAddressTag = proto.params.dstAddressTag
            let minDstReceivedAmount = proto.params.minDstReceivedAmount
            let maxFeeAmountInDstTokens = proto.params.maxFeeAmountInDstTokens

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
                let bytes = args["getOfframpStatusRequestBytes"] as? FlutterStandardTypedData,
                let proto = try? MistyswapOfframp_GetOfframpStatusRequest.init(serializedData: bytes.data),
                let clientId: Int = args["mobileCoinClientId"] as? Int,
                let client = ObjectStorage.objectForKey(clientId) as? MobileCoinClient
            else {
                result(FlutterError(code: "NATIVE", message: "GetOfframpID", details: "parsing arguments"))
                throw PluginError.invalidArguments
            }

            let offrampID = proto.offrampID

            client.getOfframpStatus(
                offrampID: offrampID
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
                let bytes = args["forgetOfframpRequestBytes"] as? FlutterStandardTypedData,
                let proto = try? MistyswapOfframp_ForgetOfframpRequest.init(serializedData: bytes.data),
                let clientId: Int = args["mobileCoinClientId"] as? Int,
                let client = ObjectStorage.objectForKey(clientId) as? MobileCoinClient
            else {
                result(FlutterError(code: "NATIVE", message: "ForgetOfframp", details: "parsing arguments"))
                throw PluginError.invalidArguments
            }

            let offrampID = proto.offrampID
            
            client.forgetOfframp(
                offrampID: offrampID
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

