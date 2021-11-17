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
                                                                                                                fogReportAttestation: fogIngestAttestation).get()).get()
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
                      throw PluginError.invalidArguments
                  }
            client.updateBalance { (balanceResult: Result<Balance, ConnectionError>) in
                switch balanceResult {
                case .success(let balance):
                    DispatchQueue.main.async {
                        result(String(balance.amountPicoMob() ?? 0))
                    }
                case .failure(let error):
                    result(FlutterError(code: "NATIVE", message: error.localizedDescription, details: nil))
                }
            }
        }
    }

    struct GetAccountActivity: Command {
        func execute(args: [String : Any], result: @escaping FlutterResult) throws {
            guard let clientId: Int = args["id"] as? Int,
                  let client = ObjectStorage.objectForKey(clientId) as? MobileCoinClient else {
                      throw PluginError.invalidArguments
                  }
            client.updateBalance { (balanceResult: Result<Balance, ConnectionError>) in
                do {
                    let activity = client.accountActivity
                    let txOuts = activity.txOuts
                    var jsonObject: [String: Any] = [:]
                    switch balanceResult {
                    case .success(let balance):
                        let balance: UInt64 = balance.amountPicoMob()!
                        jsonObject["balance"] = String(balance)
                        jsonObject["blockCount"] = String(activity.blockCount)
                        
                        var jsonTxOuts:[[String: Any]] = []
                        for txOut in txOuts {
                            var jsonTxOut: [String: Any] = [:]
                            jsonTxOut["value"] = String(txOut.value)
                            jsonTxOut["receivedDate"] = formatDate(date: txOut.receivedBlock.timestamp)
                            jsonTxOut["receivedBlock"] = String(txOut.receivedBlock.index)
                            jsonTxOut["keyImage"] = txOut.keyImage.base64EncodedString()
                            if txOut.spentBlock != nil {
                                jsonTxOut["spentDate"] = formatDate(date: txOut.spentBlock?.timestamp)
                                jsonTxOut["spentBlock"] = String(txOut.spentBlock!.index)
                            }
                            jsonTxOuts.append(jsonTxOut)
                        }
                        jsonObject["txOuts"] = jsonTxOuts
                        let jsonData = try JSONSerialization.data(withJSONObject: jsonObject, options: [])
                        let jsonString = String(data: jsonData, encoding: String.Encoding.ascii)!
                        DispatchQueue.main.async {
                            result(jsonString)
                        }
                    case .failure(let error):
                        result(FlutterError(code: "NATIVE", message: error.localizedDescription, details: nil))
                    }
                } catch let error {
                    result(FlutterError(code: "NATIVE", message: error.localizedDescription, details: nil))
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
                  let transactionId: Int = args["transactionId"] as? Int else {
                result(-1)
                throw PluginError.invalidArguments
            }

            guard let mobileCoinClient: MobileCoinClient = ObjectStorage.objectForKey(mobileClientId) as? MobileCoinClient else {
                result(-2)
                throw PluginError.invalidArguments
            }

            guard let transaction: Transaction = ObjectStorage.objectForKey(transactionId) as? Transaction else {
                result(-3)
                throw PluginError.invalidArguments
            }

            mobileCoinClient.updateBalance {_ in}
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
                    result(FlutterError(code: "NATIVE", message: error.localizedDescription, details: nil))
                }
            }
        }
    }
    
    struct SendFunds: Command {
        func execute(args: [String : Any], result: @escaping FlutterResult) throws {
            guard let mobileClientId: Int = args["id"] as? Int,
                  let recipientId: Int = args["recipient"] as? Int,
                  let feeString: String = args["fee"] as? String,
                  let fee = UInt64(feeString),
                  let amountString: String = args["amount"] as? String,
                  let amount = UInt64(amountString) else {
                      throw PluginError.invalidArguments
                  }
            guard let recipient: PublicAddress = ObjectStorage.objectForKey(recipientId) as? PublicAddress,
                  let mobileCoinClient: MobileCoinClient = ObjectStorage.objectForKey(mobileClientId) as? MobileCoinClient else {
                      throw PluginError.invalidArguments
                  }
            mobileCoinClient.prepareTransaction(to: recipient, amount: amount, fee: fee) { (pendingTx: Result<(transaction: Transaction, receipt: Receipt), TransactionPreparationError>) in
                switch pendingTx {
                case .success(let (transaction, _)):
                    mobileCoinClient.submitTransaction(transaction) { (txResult: Result<(), TransactionSubmissionError>) in
                        switch txResult {
                        case .success():
                            let hashCode = transaction.hashValue
                            ObjectStorage.addObject(transaction, forKey: hashCode)
                            result(hashCode)
                        case .failure(let error):
                            result(FlutterError(code: "NATIVE", message: error.localizedDescription, details: nil))
                        }
                        
                    }
                case .failure(let e):
                    result(FlutterError(code: "NATIVE", message: e.localizedDescription, details: nil))
                }
            }
        }
    }
}
