//
//  FFiMobileCoinClient.swift
//  mobilecoin_flutter
//
//  Created by Alexander Voloshyn on 9/29/20.
//

import Foundation
import MobileCoin

struct FfiMobileCoinClient {
    
    static let PROD_MRSIGNER_HEX = 
    "2c1a561c4ab64cbc04bfa445cdf7bed9b2ad6f6b04d38d3137f3622b29fdb30e"
    static let PROD_MRSIGNER = Data([
        44, 26, 86, 28, 74, 182, 76, 188, 4, 191, 164, 69, 205, 247, 190, 217, 178, 173, 111, 
        107, 4, 211, 141, 49, 55, 243, 98, 43, 41, 253, 179, 14,
    ])
    static let TESTNET_MRSIGNER_HEX =
    "bf7fa957a6a94acb588851bc8767eca5776c79f4fc2aa6bcb99312c3c386c"
    static let TESTNET_MRSIGNER = Data([
        191, 127, 169, 87, 166, 169, 74, 203, 88, 136, 81, 188, 135, 103, 224, 202, 87, 112, 108,
        121, 244, 252, 42, 166, 188, 185, 147, 1, 44, 60, 56, 108,
    ])

    static let CONSENSUS_PRODUCT_ID: UInt16 = 1
    static let CONSENSUS_SECURITY_VERSION: UInt16 = 1
    
    static let FOG_VIEW_PRODUCT_ID: UInt16 = 3
    static let FOG_VIEW_SECURITY_VERSION: UInt16 = 1
    
    static let FOG_LEDGER_PRODUCT_ID: UInt16 = 2
    static let FOG_LEDGER_SECURITY_VERSION: UInt16 = 1
    
    static let FOG_INGEST_PRODUCT_ID: UInt16 = 4
    static let FOG_INGEST_SECURITY_VERSION: UInt16 = 1
    
    struct Create: Command {
        func execute(args: [String : Any], result: @escaping FlutterResult) throws {
            guard let accountKeyId = args["accountKey"] as? Int,
                  let fogUrl = args["fogUrl"] as? String,
                  let consensusUrl = args["consensusUrl"] as? String,
                  let useTestNet = args["useTestNet"] as? Bool,
                  let accountKey = ObjectStorage.objectForKey(accountKeyId) as? AccountKey else {
                      result(FlutterError(code: "NATIVE", message: "Create", details: "parsing arguments"))
                      throw PluginError.invalidArguments
                  }
            let consensusMrSigner = Attestation.MrSigner.make(
                mrSigner: useTestNet ? TESTNET_MRSIGNER : PROD_MRSIGNER,
                productId: CONSENSUS_PRODUCT_ID,
                minimumSecurityVersion: CONSENSUS_SECURITY_VERSION,
                allowedConfigAdvisories: ["INTEL-SA-00334"],
                allowedHardeningAdvisories: ["INTEL-SA-00334"]
            )
            let consensusAttestation = try Attestation(consensusMrSigner.get())
            
            let fogViewMrSigner = Attestation.MrSigner.make(
                mrSigner: useTestNet ? TESTNET_MRSIGNER : PROD_MRSIGNER,
                productId: FOG_VIEW_PRODUCT_ID,
                minimumSecurityVersion: FOG_VIEW_SECURITY_VERSION,
                allowedConfigAdvisories: ["INTEL-SA-00334"],
                allowedHardeningAdvisories: ["INTEL-SA-00334"]
            )
            let fogViewAttestation = try Attestation(fogViewMrSigner.get())
            
            let fogLedgerMrSigner = Attestation.MrSigner.make(
                mrSigner: useTestNet ? TESTNET_MRSIGNER : PROD_MRSIGNER,
                productId: FOG_LEDGER_PRODUCT_ID,
                minimumSecurityVersion: FOG_LEDGER_SECURITY_VERSION,
                allowedConfigAdvisories: ["INTEL-SA-00334"],
                allowedHardeningAdvisories: ["INTEL-SA-00334"]
            )
            let fogKeyImageAttestation = try Attestation(fogLedgerMrSigner.get())
            
            let fogIngestMrSigner = Attestation.MrSigner.make(
                mrSigner: useTestNet ? TESTNET_MRSIGNER : PROD_MRSIGNER,
                productId: FOG_INGEST_PRODUCT_ID,
                minimumSecurityVersion: FOG_INGEST_SECURITY_VERSION,
                allowedConfigAdvisories: ["INTEL-SA-00334"],
                allowedHardeningAdvisories: ["INTEL-SA-00334"]
            )
            let fogIngestAttestation = try Attestation(fogIngestMrSigner.get())
            
            let client = try MobileCoinClient.make(accountKey: accountKey, config: MobileCoinClient.Config.make(consensusUrl: consensusUrl,
                                                                                                                consensusAttestation: consensusAttestation,
                                                                                                                fogUrl: fogUrl,
                                                                                                                fogViewAttestation: fogViewAttestation,
                                                                                                                fogKeyImageAttestation: fogKeyImageAttestation,
                                                                                                                fogMerkleProofAttestation: fogKeyImageAttestation,
                                                                                                                fogReportAttestation: fogIngestAttestation,
                                                                                                                transportProtocol: .grpc).get()).get()
            let hash: Int = ObjectIdentifier(client).hashValue
            ObjectStorage.addObject(client, forKey: hash)
            result(hash)
        }
    }
    
    struct SetAuthorization: Command {
        func execute(args: [String : Any], result: @escaping FlutterResult) throws {
            guard let clientId: Int = args["id"] as? Int,
                  let username = args["username"] as? String,
                  let password = args["password"] as? String,
                  let client = ObjectStorage.objectForKey(clientId) as? MobileCoinClient else {
                      result(FlutterError(code: "NATIVE", message: "SetAuthorization", details: "parsing arguments"))
                      throw PluginError.invalidArguments
                  }
            client.setFogBasicAuthorization(username: username, password: password)
            client.setConsensusBasicAuthorization(username: username, password: password)
            result(0)
        }
    };
    
    struct GetBalance: Command {
        func execute(args: [String : Any], result: @escaping FlutterResult) throws {
            guard let clientId: Int = args["id"] as? Int,
                  let client = ObjectStorage.objectForKey(clientId) as? MobileCoinClient else {
                      result(FlutterError(code: "NATIVE", message: "GetBalance", details: "parsing arguments"))
                      throw PluginError.invalidArguments
                  }
            client.updateBalances { (balanceResult: Result<Balances, BalanceUpdateError>) in
                switch balanceResult {
                case .success(let balances):
                    var resultJson: [String: Any] = [:]
                    for tokenId in balances.tokenIds {
                        let balance = balances.balances[tokenId]
                        resultJson[String(tokenId.value)] = String(balance?.amount() ?? 0)
                    }
                    let resultData = try! JSONSerialization.data(withJSONObject: resultJson, options: [])
                    let resultString = String(data: resultData, encoding: String.Encoding.ascii)!

                    DispatchQueue.main.async {
                        result(resultString)
                    }
                case .failure(let error):
                    result(FlutterError(code: "NATIVE", message: error.localizedDescription, details: "GetBalance.updateBalance"))
                }
            }
        }
    }

    struct GetAccountActivity: Command {
        func execute(args: [String : Any], result: @escaping FlutterResult) throws {
            guard let clientId: Int = args["id"] as? Int,
                  let client = ObjectStorage.objectForKey(clientId) as? MobileCoinClient else {
                      result(FlutterError(code: "NATIVE", message: "GetAccountActivity", details: "parsing arguments"))
                      throw PluginError.invalidArguments
                  }
            client.updateBalances { (balanceResult: Result<Balances, BalanceUpdateError>) in
                do {
                    switch balanceResult {
                    case .success(let balances):
                        var resultJson: [String: Any] = [:]
                        for tokenId in balances.tokenIds {
                            let activity = client.accountActivity(for: tokenId)
                            let txOuts = activity.txOuts
                            var jsonObject: [String: Any] = [:]

                            let balance: UInt64 = balances.balances[tokenId]?.amount() ?? 0
                            jsonObject["balance"] = String(balance)
                            jsonObject["blockCount"] = String(activity.blockCount)
                            
                            var jsonTxOuts:[[String: Any]] = []
                            for txOut in txOuts {
                                var jsonTxOut: [String: Any] = [:]
                                jsonTxOut["value"] = String(txOut.value)
                                jsonTxOut["receivedDate"] = formatDate(date: txOut.receivedBlock.timestamp)
                                jsonTxOut["publicKey"] = txOut.publicKey.base64EncodedString()
                                jsonTxOut["receivedBlock"] = String(txOut.receivedBlock.index)
                                jsonTxOut["keyImage"] = txOut.keyImage.base64EncodedString()
                                jsonTxOut["sharedSecret"] = txOut.sharedSecret.base64EncodedString()
                                if txOut.spentBlock != nil {
                                    jsonTxOut["spentBlock"] = String(txOut.spentBlock!.index)

                                    // spentBlockTimestamp is null when checking a spent TxOut before Fog Ledger knows it is spent
                                    if (txOut.spentBlock!.timestamp != nil) {
                                        jsonTxOut["spentDate"] = formatDate(date: txOut.spentBlock!.timestamp)
                                    }
                                }
                                jsonTxOuts.append(jsonTxOut)
                            }
                            jsonObject["txOuts"] = jsonTxOuts
                            resultJson[String(tokenId.value)] = jsonObject
                        }
                        let jsonData = try JSONSerialization.data(withJSONObject: resultJson, options: [])
                        let jsonString = String(data: jsonData, encoding: String.Encoding.ascii)!
                        DispatchQueue.main.async {
                            result(jsonString)
                        }
                    case .failure(let error):
                        result(FlutterError(code: "NATIVE", message: error.localizedDescription, details: "GetAccountActivity.serialize"))
                    }
                } catch let error {
                    result(FlutterError(code: "NATIVE", message: error.localizedDescription, details: "GetAccountActivity.updateBalance"))
                }
            }
            func formatDate(date: Date?) -> String? {
                if let date = date {
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "MM/dd/yyyy KK:mm:ss a Z"
                    return dateFormatter.string(from: date)
                }
                return nil
            }
        }
    }

    struct CheckTransactionStatus: Command {
        func execute(args: [String : Any], result: @escaping FlutterResult) throws {
            guard let mobileClientId: Int = args["id"] as? Int,
                  let receiptId: Int = args["receiptId"] as? Int else {
                result(FlutterError(code: "NATIVE", message: "CheckTransactionStatus", details: "parsing arguments"))
                throw PluginError.invalidArguments
            }
            guard let mobileCoinClient: MobileCoinClient = ObjectStorage.objectForKey(mobileClientId) as? MobileCoinClient else {
                result(FlutterError(code: "NATIVE", message: "CheckTransactionStatus", details: "retrieve client"))
                throw PluginError.invalidArguments
            }

            guard let transaction: Transaction = ObjectStorage.objectForKey(receiptId) as? Transaction else {
                result(FlutterError(code: "NATIVE", message: "CheckTransactionStatus", details: "deserializing transaction"))
                throw PluginError.invalidArguments
            }

            // more race condition testing will need to be done before changing this to `txOutStatus`
            mobileCoinClient.status(of: transaction) { (statusResult: Result<TransactionStatus, ConnectionError>) in
                switch statusResult {
                case .success(let status):
                    switch status {
                    case .unknown:
                        result(0)
                    case .accepted(block: _):
                        result(1)
                    case .failed:
                        result(2)
                    }
                case .failure(let error):
                    result(FlutterError(code: "NATIVE", message: error.localizedDescription, details: "CheckTransactionStatus.updateBalance"))
                }
            }
        }
    }
    
    struct CreatePendingTransaction: Command {
        func execute(args: [String : Any], result: @escaping FlutterResult) throws {
            guard let mobileClientId: Int = args["id"] as? Int,
                  let recipientId: Int = args["recipient"] as? Int,
                  let feeString: String = args["fee"] as? String,
                  let rngSeed: FlutterStandardTypedData = args["rngSeed"] as? FlutterStandardTypedData,
                  let fee = UInt64(feeString),
                  let tokenId = args["tokenId"] as? UInt64,
                  let amountString: String = args["amount"] as? String,
                  let parsedAmount = UInt64(amountString) else {
                      result(FlutterError(code: "NATIVE", message: "CreatePendingTransaction", details: "parsing arguments"))
                      throw PluginError.invalidArguments
                  }
            let amount = Amount(parsedAmount, in: TokenId(tokenId))
            // rngSeed is required for now. If it were ever to be optional, we would need to utilize wordPos
            guard let rng = RngSeed(rngSeed.data) else {
                result(FlutterError(code: "NATIVE", message: "CreatePendingTransaction", details: "rngSeed required"))
                throw PluginError.invalidArguments
            }

            guard let recipient: PublicAddress = ObjectStorage.objectForKey(recipientId) as? PublicAddress,
                  let mobileCoinClient: MobileCoinClient = ObjectStorage.objectForKey(mobileClientId) as? MobileCoinClient else {
                      result(FlutterError(code: "NATIVE", message: "CreatePendingTransaction", details: "retrieve client"))
                      throw PluginError.invalidArguments
                  }
            mobileCoinClient.prepareTransaction(to: recipient, memoType: .recoverable, amount: amount, fee: fee, rngSeed: rng) { (pendingTx: Result<PendingSinglePayloadTransaction, TransactionPreparationError>) in
                switch pendingTx {
                case .success(let (pending)):
                    var returnPayload: [String: Any] = [:]

                    returnPayload["transaction"] = FlutterStandardTypedData(bytes: pending.transaction.serializedData)

                    let payloadTxOutPublicKey = pending.payloadTxOutContext.txOutPublicKey
                    let payloadTxOutSharedSecret = pending.payloadTxOutContext.sharedSecretBytes
                    let changeTxOutPublicKey = pending.changeTxOutContext.txOutPublicKey
                    let changeTxOutSharedSecret = pending.changeTxOutContext.sharedSecretBytes

                    returnPayload["payloadTxOutPublicKey"] = payloadTxOutPublicKey.base64EncodedString()
                    returnPayload["payloadTxOutSharedSecret"] = payloadTxOutSharedSecret.base64EncodedString()
                    returnPayload["changeTxOutPublicKey"] = changeTxOutPublicKey.base64EncodedString()
                    returnPayload["changeTxOutSharedSecret"] = changeTxOutSharedSecret.base64EncodedString()

                    result(returnPayload)
                case .failure(let e):
                    result(FlutterError(code: "NATIVE", message: e.localizedDescription, details: "CreatePendingTransaction.prepareTransaction"))
                }
            }
        }
    }

    struct SendFunds: Command {
        func execute(args: [String : Any], result: @escaping FlutterResult) throws {
            guard let mobileClientId: Int = args["id"] as? Int,
                  let serializedTransaction: FlutterStandardTypedData = args["transaction"] as? FlutterStandardTypedData else {
                      result(FlutterError(code: "NATIVE", message: "SendFunds", details: "parsing arguments"))
                      throw PluginError.invalidArguments
                  }

            guard let mobileCoinClient: MobileCoinClient = ObjectStorage.objectForKey(mobileClientId) as? MobileCoinClient else {
                    result(FlutterError(code: "NATIVE", message: "SendFunds", details: "retrieve client"))
                    throw PluginError.invalidArguments
                }

            guard let transaction: Transaction = Transaction.init(serializedData: Data(serializedTransaction.data)) else {
                    result(FlutterError(code: "NATIVE", message: "SendFunds", details: "deserializing transaction"))
                    throw PluginError.invalidArguments
                }

            let receiptId = transaction.hashValue

            ObjectStorage.addObject(transaction, forKey: receiptId);

            mobileCoinClient.submitTransaction(transaction: transaction) { (txResult: Result<(UInt64), SubmitTransactionError>) in
                var jsonObject: [String: Any] = [:]
                do {
                    switch txResult {
                    case .success(let blockIndex):
                        jsonObject["status"] = "OK"
                        jsonObject["blockIndex"] = blockIndex
                        jsonObject["receiptId"] = receiptId
                    case .failure(let error):
                        switch error.submissionError {
                        case .connectionError:
                            jsonObject["status"] = "CONNECTION_ERROR"
                        case .missingMemo:
                            jsonObject["status"] = "MISSING_MEMO"
                        case .feeError:
                            jsonObject["status"] = "FEE_ERROR"
                        case .invalidTransaction:
                            jsonObject["status"] = "INVALID_TRANSACTION"
                        case .tombstoneBlockTooFar:
                            jsonObject["status"] = "TOMBSTONE_BLOCK_TOO_FAR"
                        case .inputsAlreadySpent:
                            jsonObject["status"] = "INPUT_ALREADY_SPENT"
                        case .outputAlreadyExists(_):
                            jsonObject["status"] = "OUTPUT_ALREADY_EXISTS"
                        }

                        jsonObject["blockIndex"] = error.consensusBlockCount
                    }

                    let jsonData = try JSONSerialization.data(withJSONObject: jsonObject, options: [])
                    let jsonString = String(data: jsonData, encoding: String.Encoding.ascii)!
                    result(jsonString)
                } catch let error {
                    result(FlutterError(code: "NATIVE", message: error.localizedDescription, details: "SendFunds.json"))
                }
            }
        }
    }
}
