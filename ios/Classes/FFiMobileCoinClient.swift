//
//  FFiMobileCoinClient.swift
//  mobilecoin_flutter
//
//  Created by Alexander Voloshyn on 9/29/20.
//

import Foundation
import MobileCoin

struct FfiMobileCoinClient {

    static let CONSENSUS_PRODUCT_ID: UInt16 = 1
    static let CONSENSUS_SECURITY_VERSION: UInt16 = 1
    static let DEV_CONSENSUS_MRSIGNER_HEX =
        "7ee5e29d74623fdbc6fbf1454be6f3bb0b86c12366b7b478ad13353e44de8411"
    static let DEV_CONSENSUS_MRSIGNER = Data([
        126, 229, 226, 157, 116, 98, 63, 219, 198, 251, 241, 69, 75, 230, 243, 187, 11, 134, 193,
        35, 102, 183, 180, 120, 173, 19, 53, 62, 68, 222, 132, 17,
    ])
    static let TESTNET_CONSENSUS_MRSIGNER_HEX =
        "bf7fa957a6a94acb588851bc8767eca5776c79f4fc2aa6bcb99312c3c386c"
    static let TESTNET_CONSENSUS_MRSIGNER = Data([
        191, 127, 169, 87, 166, 169, 74, 203, 88, 136, 81, 188, 135, 103, 224, 202, 87, 112, 108,
        121, 244, 252, 42, 166, 188, 185, 147, 1, 44, 60, 56, 108,
    ])

    static let FOG_VIEW_PRODUCT_ID: UInt16 = 3
    static let FOG_VIEW_SECURITY_VERSION: UInt16 = 1
    static let DEV_FOG_VIEW_MRSIGNER_HEX =
        "7ee5e29d74623fdbc6fbf1454be6f3bb0b86c12366b7b478ad13353e44de8411"
    static let DEV_FOG_VIEW_MRSIGNER = Data([
        126, 229, 226, 157, 116, 98, 63, 219, 198, 251, 241, 69, 75, 230, 243, 187, 11, 134, 193,
        35, 102, 183, 180, 120, 173, 19, 53, 62, 68, 222, 132, 17,
    ])
    static let TESTNET_FOG_VIEW_MRSIGNER_HEX =
        "bf7fa957a6a94acb588851bc8767eca5776c79f4fc2aa6bcb99312c3c386c"
    static let TESTNET_FOG_VIEW_MRSIGNER = Data([
        191, 127, 169, 87, 166, 169, 74, 203, 88, 136, 81, 188, 135, 103, 224, 202, 87, 112, 108,
        121, 244, 252, 42, 166, 188, 185, 147, 1, 44, 60, 56, 108,
    ])

    static let FOG_LEDGER_PRODUCT_ID: UInt16 = 2
    static let FOG_LEDGER_SECURITY_VERSION: UInt16 = 1
    static let DEV_FOG_LEDGER_MRSIGNER_HEX =
        "7ee5e29d74623fdbc6fbf1454be6f3bb0b86c12366b7b478ad13353e44de8411"
    static let DEV_FOG_LEDGER_MRSIGNER = Data([
        126, 229, 226, 157, 116, 98, 63, 219, 198, 251, 241, 69, 75, 230, 243, 187, 11, 134, 193,
        35, 102, 183, 180, 120, 173, 19, 53, 62, 68, 222, 132, 17,
    ])
    static let TESTNET_FOG_LEDGER_MRSIGNER_HEX =
        "bf7fa957a6a94acb588851bc8767eca5776c79f4fc2aa6bcb99312c3c386c"
    static let TESTNET_FOG_LEDGER_MRSIGNER = Data([
        191, 127, 169, 87, 166, 169, 74, 203, 88, 136, 81, 188, 135, 103, 224, 202, 87, 112, 108,
        121, 244, 252, 42, 166, 188, 185, 147, 1, 44, 60, 56, 108,
    ])

    static let FOG_INGEST_PRODUCT_ID: UInt16 = 4
    static let FOG_INGEST_SECURITY_VERSION: UInt16 = 1
    static let DEV_FOG_INGEST_MRSIGNER_HEX =
        "7ee5e29d74623fdbc6fbf1454be6f3bb0b86c12366b7b478ad13353e44de8411"
    static let DEV_FOG_INGEST_MRSIGNER = Data([
        126, 229, 226, 157, 116, 98, 63, 219, 198, 251, 241, 69, 75, 230, 243, 187, 11, 134, 193,
        35, 102, 183, 180, 120, 173, 19, 53, 62, 68, 222, 132, 17,
    ])
    static let TESTNET_FOG_INGEST_MRSIGNER_HEX =
        "bf7fa957a6a94acb588851bc8767eca5776c79f4fc2aa6bcb99312c3c386c"
    static let TESTNET_FOG_INGEST_MRSIGNER = Data([
        191, 127, 169, 87, 166, 169, 74, 203, 88, 136, 81, 188, 135, 103, 224, 202, 87, 112, 108,
        121, 244, 252, 42, 166, 188, 185, 147, 1, 44, 60, 56, 108,
    ])



    struct Create: Command {
        func execute(args: [String : Any], result: @escaping FlutterResult) throws {
            guard let accountKeyId = args["accountKey"] as? Int,
                  let fogUrl = args["fogUrl"] as? String,
                  let consensusUrl = args["consensusUrl"] as? String,
                  let accountKey = ObjectStorage.objectForKey(accountKeyId) as? AccountKey else {
                throw PluginError.invalidArguments
            }
            let consensusMrSigner = Attestation.MrSigner.make(
                mrSigner: TESTNET_CONSENSUS_MRSIGNER,
                productId: CONSENSUS_PRODUCT_ID,
                minimumSecurityVersion: CONSENSUS_SECURITY_VERSION,
                allowedConfigAdvisories: ["INTEL-SA-00334"],
                allowedHardeningAdvisories: ["INTEL-SA-00334"]
            )
            let consensusAttestation = try Attestation(consensusMrSigner.get())

            let fogViewMrSigner = Attestation.MrSigner.make(
                mrSigner: TESTNET_FOG_VIEW_MRSIGNER,
                productId: FOG_VIEW_PRODUCT_ID,
                minimumSecurityVersion: FOG_VIEW_SECURITY_VERSION,
                allowedConfigAdvisories: ["INTEL-SA-00334"],
                allowedHardeningAdvisories: ["INTEL-SA-00334"]
            )
            let fogViewAttestation = try Attestation(fogViewMrSigner.get())
                
            let fogLedgerMrSigner = Attestation.MrSigner.make(
                mrSigner: TESTNET_FOG_LEDGER_MRSIGNER,
                productId: FOG_LEDGER_PRODUCT_ID,
                minimumSecurityVersion: FOG_LEDGER_SECURITY_VERSION,
                allowedConfigAdvisories: ["INTEL-SA-00334"],
                allowedHardeningAdvisories: ["INTEL-SA-00334"]
            )
            let fogKeyImageAttestation = try Attestation(fogLedgerMrSigner.get())
            
            let fogIngestMrSigner = Attestation.MrSigner.make(
                mrSigner: TESTNET_FOG_INGEST_MRSIGNER,
                productId: FOG_INGEST_PRODUCT_ID,
                minimumSecurityVersion: FOG_INGEST_SECURITY_VERSION,
                allowedConfigAdvisories: ["INTEL-SA-00334"],
                allowedHardeningAdvisories: ["INTEL-SA-00334"]
            )
            let fogIngestAttestation = try Attestation(fogIngestMrSigner.get())
            
            let client = try! MobileCoinClient.make(accountKey: accountKey, config: MobileCoinClient.Config.make(consensusUrl: consensusUrl,
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
                  let password = args["password"] as? String else {
                throw PluginError.invalidArguments
            }
            
            let client = ObjectStorage.objectForKey(clientId) as! MobileCoinClient
            client.setFogBasicAuthorization(username: username, password: password)
            client.setConsensusBasicAuthorization(username: username, password: password)
            result(0)
        }
    };
    
    struct GetBalance: Command {
        func execute(args: [String : Any], result: @escaping FlutterResult) throws {
            let clientId: Int = args["id"] as! Int
            let client = ObjectStorage.objectForKey(clientId) as! MobileCoinClient
            client.updateBalance {
                do {
                    let balance = try $0.get()
                    DispatchQueue.main.async {
                        result(String(balance.amountPicoMob() ?? 0))
                    }
                } catch let error {
                    result(FlutterError(code: "-1", message: error.localizedDescription, details: error))
                }
            }
        }
    }

    struct GetAccountActivity: Command {
        func execute(args: [String : Any], result: @escaping FlutterResult) throws {
            let clientId: Int = args["id"] as! Int
            let client = ObjectStorage.objectForKey(clientId) as! MobileCoinClient
            client.updateBalance {
                do {
                    let activity = client.accountActivity
                    let txOuts = activity.txOuts
                    var jsonObject: [String: Any] = [:]
                    switch $0 {
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
                        result(FlutterError(code: "-1", message: error.localizedDescription, details: nil))
                    }
                } catch let error {
                    result(FlutterError(code: "-1", message: error.localizedDescription, details: nil))
                }
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
    
    struct SendFunds: Command {
        func execute(args: [String : Any], result: @escaping FlutterResult) throws {
            let mobileClientId: Int = args["id"] as! Int
            let recipientId: Int = args["recipient"] as! Int
            let fee: UInt64 = UInt64(args["fee"] as! String)! // TODO: use PicoMob class instead
            let amount: UInt64 = UInt64(args["amount"] as! String)! // TODO: use PicoMob class instead
            var checkStatus: (() -> Void)!
            let recipient: PublicAddress = ObjectStorage.objectForKey(recipientId) as! PublicAddress
            let mobileCoinClient: MobileCoinClient = ObjectStorage.objectForKey(mobileClientId) as! MobileCoinClient
            mobileCoinClient.prepareTransaction(to: recipient, amount: amount, fee: fee) { (pendingTx: Result<(transaction: Transaction, receipt: Receipt), TransactionPreparationError>) in
                switch pendingTx {
                case .success(let (transaction, receipt)):
                    mobileCoinClient.submitTransaction(transaction) { (_: Result<(), TransactionSubmissionError>) in
                        checkStatus = {
                            mobileCoinClient.updateBalance {_ in}
                            mobileCoinClient.status(of: transaction) { (status: Result<TransactionStatus, ConnectionError>) in
                                guard let status = try? status.get() else {
                                    result(FlutterError(code: "-1", message: "Unable to obtain transaction status", details: nil))
                                    return
                                }
                                switch status {
                                case .unknown:
                                    DispatchQueue.global(qos: .background).asyncAfter(deadline: DispatchTime.now() + .seconds(2)) {
                                        checkStatus()
                                    }
                                case .accepted(block: _):
                                    let hashCode = receipt.hashValue
                                    ObjectStorage.addObject(receipt, forKey: hashCode)
                                    result(hashCode)
                                case .failed:
                                    result(FlutterError(code: "-1", message: "Transaction failed", details: nil))
                                }
                            }
                        }
                        checkStatus()
                    }
                case .failure(let e):
                    result(FlutterError(code: "-1", message: e.localizedDescription, details: nil))
                }
            }
        }
    }
}
