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

    struct Contact: PublicAddressProvider, Hashable {
        let name: String
        let username: String
        let publicAddress: PublicAddress
    }

    struct GetAccountActivity: Command {
        func assembleContacts(serializedPublicAddresses: [FlutterStandardTypedData]) -> Set<Contact> {
            var contacts = Set<Contact>();

            for serializedPublicAddress in serializedPublicAddresses {
                guard let addressAsString: String = String(bytes: serializedPublicAddress.data, encoding: .utf8) else { continue }
                guard case .publicAddress(let address) = Base58Coder.decode(addressAsString) else { continue }

                contacts.insert(Contact(name: "", username: "", publicAddress: address))
            }

            return contacts
        }

        func execute(args: [String : Any], result: @escaping FlutterResult) throws {
            guard let clientId: Int = args["id"] as? Int,
                  let publicAddresses = args["serializedPublicAddresses"] as? [FlutterStandardTypedData],
                  let client = ObjectStorage.objectForKey(clientId) as? MobileCoinClient else {
                      result(FlutterError(code: "NATIVE", message: "GetAccountActivity", details: "parsing arguments"))
                      throw PluginError.invalidArguments
                  }
            let contacts = assembleContacts(serializedPublicAddresses: publicAddresses)
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
                            let recoveredTransactions = MobileCoinClient.recoverTransactions(txOuts, contacts: contacts)

                            var jsonTxOuts:[[String: Any]] = []
                            for transaction in recoveredTransactions {
                                let txOut = transaction.txOut
                                var jsonTxOut: [String: Any] = [:]
                                jsonTxOut["value"] = String(txOut.value)
                                jsonTxOut["receivedDate"] = txOut.receivedBlock.timestamp?.millisecondsSince1970
                                jsonTxOut["publicKey"] = txOut.publicKey.base64EncodedString()
                                jsonTxOut["receivedBlock"] = String(txOut.receivedBlock.index)
                                jsonTxOut["keyImage"] = txOut.keyImage.base64EncodedString()
                                jsonTxOut["sharedSecret"] = txOut.sharedSecret.base64EncodedString()

                                if transaction.memo != nil {
                                    jsonTxOut["theirAddressHashHex"] = transaction.memo!.addressHashHex
                                }

                                if txOut.spentBlock != nil {
                                    jsonTxOut["spentBlock"] = String(txOut.spentBlock!.index)

                                    // spentBlockTimestamp is null when checking a spent TxOut before Fog Ledger knows it is spent
                                    if (txOut.spentBlock!.timestamp != nil) {
                                        jsonTxOut["spentDate"] = txOut.spentBlock!.timestamp?.millisecondsSince1970
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

            mobileCoinClient.updateBalances { (balanceResult: Result<Balances, BalanceUpdateError>) in
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
    }
    
    struct CreatePendingTransaction: Command {
        func execute(args: [String : Any], result: @escaping FlutterResult) throws {
            guard let mobileClientId: Int = args["id"] as? Int,
                  let recipientId: Int = args["recipient"] as? Int,
                  let feeString: String = args["fee"] as? String,
                  let rngSeed: FlutterStandardTypedData = args["rngSeed"] as? FlutterStandardTypedData,
                  let fee = UInt64(feeString),
                  let tokenIdString = args["tokenId"] as? String,
                  let tokenId = UInt64(tokenIdString),
                  let amountString: String = args["amount"] as? String,
                  let parsedAmount = UInt64(amountString) else {
                      result(FlutterError(code: "NATIVE", message: "CreatePendingTransaction", details: "parsing arguments"))
                      throw PluginError.invalidArguments
                  }
            let amount = Amount(parsedAmount, in: TokenId(tokenId))
            let rng = MobileCoinChaCha20Rng(seed: rngSeed.data)

            guard let recipient: PublicAddress = ObjectStorage.objectForKey(recipientId) as? PublicAddress,
                  let mobileCoinClient: MobileCoinClient = ObjectStorage.objectForKey(mobileClientId) as? MobileCoinClient else {
                      result(FlutterError(code: "NATIVE", message: "CreatePendingTransaction", details: "retrieve client"))
                      throw PluginError.invalidArguments
                  }
            mobileCoinClient.prepareTransaction(to: recipient, memoType: .recoverable, amount: amount, fee: fee, rng: rng) {
                (pendingTx: Result<PendingSinglePayloadTransaction, TransactionPreparationError>) in
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

// From https://stackoverflow.com/a/40135192/1411004
extension Date {
    var millisecondsSince1970:Int64 {
        Int64((self.timeIntervalSince1970 * 1000.0).rounded())
    }

    init(milliseconds:Int64) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds) / 1000)
    }
}

extension RecoveredMemo {
    var addressHashHex: String {
        switch self {
        case let .senderWithPaymentRequest(memo):
            return memo.addressHashHex
        case let .sender(memo):
            return memo.addressHashHex
        case let .destination(memo):
            return memo.addressHashHex
        }
    }
}
