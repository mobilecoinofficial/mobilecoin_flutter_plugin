// Copyright (c) 2021-2024 MobileCoin. All rights reserved.

import Foundation
import MobileCoin

struct FfiMobileCoinClient {

    struct Create: Command {
        func execute(args: [String : Any], result: @escaping FlutterResult) throws {
            guard
                let accountKeyId = args["accountKey"] as? Int,
                let fogUrl = args["fogUrl"] as? String,
                let consensusUrl = args["consensusUrl"] as? String,
                let clientConfigId = args["clientConfigId"] as? Int,
                let clientConfig = ObjectStorage.objectForKey(clientConfigId) as? ClientConfig,
                let accountKey = ObjectStorage.objectForKey(accountKeyId) as? AccountKey
            else {
                result(FlutterError(code: "NATIVE", message: "Create", details: "parsing arguments"))
                throw PluginError.invalidArguments
            }

            let consensusMrEnclave = clientConfig.consensusMrEnclaves
            let fogViewMrEnclave = clientConfig.fogViewMrEnclaves
            let fogReportMrEnclave = clientConfig.fogReportMrEnclaves
            let fogLedgerMrEnclave = clientConfig.fogLedgerMrEnclaves
            let mistyswapMrEnclave = clientConfig.mistyswapMrEnclaves

            // Ensure one or more valid MrEnclaves for each service thats required
            guard
                consensusMrEnclave.count > 0,
                fogViewMrEnclave.count > 0,
                fogReportMrEnclave.count > 0,
                fogLedgerMrEnclave.count > 0
            else {
                result(FlutterError(code: "NATIVE", message: "Create", details: "parsing arguments"))
                throw PluginError.invalidArguments
            }

            let consensusAttestation = Attestation(mrEnclaves: consensusMrEnclave)
            let fogViewAttestation = Attestation(mrEnclaves: fogViewMrEnclave)
            let fogReportAttestation = Attestation(mrEnclaves: fogReportMrEnclave)
            let fogLedgerAttestation = Attestation(mrEnclaves: fogLedgerMrEnclave)
            let mistyswapAttestation = Attestation(mrEnclaves: mistyswapMrEnclave)

            let client: MobileCoinClient = try {
                let transportProtocol = TransportProtocol.http

                guard let mistyswapUrl = args["mistyswapUrl"] as? String
                else {
                    return try MobileCoinClient.make(
                        accountKey: accountKey,
                        config: MobileCoinClient.Config.make(
                            consensusUrl: consensusUrl,
                            consensusAttestation: consensusAttestation,
                            fogUrl: fogUrl,
                            fogViewAttestation: fogViewAttestation,
                            fogKeyImageAttestation: fogLedgerAttestation,
                            fogMerkleProofAttestation: fogLedgerAttestation,
                            fogReportAttestation: fogReportAttestation,
                            transportProtocol: transportProtocol
                        ).get()
                    ).get()
                }
                return try MobileCoinClient.make(
                    accountKey: accountKey,
                    config: MobileCoinClient.Config.make(
                        consensusUrl: consensusUrl,
                        consensusAttestation: consensusAttestation,
                        fogUrl: fogUrl,
                        fogViewAttestation: fogViewAttestation,
                        fogKeyImageAttestation: fogLedgerAttestation,
                        fogMerkleProofAttestation: fogLedgerAttestation,
                        fogReportAttestation: fogReportAttestation,
                        mistyswapUrl: mistyswapUrl,
                        mistyswapAttestation: mistyswapAttestation,
                        transportProtocol: transportProtocol
                    ).get()
                ).get()
            }()

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

    struct RequiresDefragmentation: Command {
        func execute(args: [String : Any], result: @escaping FlutterResult) throws {
            guard let clientId: Int = args["id"] as? Int,
                  let toSendAmountString = args["amount"] as? String,
                  let toSendAmount = UInt64(toSendAmountString),
                  let toSendTokenIdString = args["tokenId"] as? String,
                  let toSendTokenIdUInt = UInt64(toSendTokenIdString),
                  let client = ObjectStorage.objectForKey(clientId) as? MobileCoinClient else {
                      result(FlutterError(code: "NATIVE", message: "RequiresDefragmentation", details: "parsing arguments"))
                      throw PluginError.invalidArguments
                  }

            let toSendTokenId = TokenId(toSendTokenIdUInt)
            let amount = Amount(toSendAmount, in: toSendTokenId)

            client.requiresDefragmentation(toSendAmount: amount) { (requiresDefragResult: Result<Bool, TransactionEstimationFetcherError>) in
                switch requiresDefragResult {
                case .success(let requiresDefragmentation):
                    DispatchQueue.main.async {
                        result(requiresDefragmentation)
                    }
                case .failure(let error):
                    result(FlutterError(code: "NATIVE", message: error.localizedDescription, details: "RequiresDefragmentation.requiresDefragmentation"))
                }
            }
        }
    }

    struct EstimateTotalFee: Command {
        func execute(args: [String : Any], result: @escaping FlutterResult) throws {
            guard let clientId: Int = args["id"] as? Int,
                  let toSendAmountString = args["amount"] as? String,
                  let toSendAmount = UInt64(toSendAmountString),
                  let toSendTokenIdString = args["tokenId"] as? String,
                  let toSendTokenIdUInt = UInt64(toSendTokenIdString),
                  let client = ObjectStorage.objectForKey(clientId) as? MobileCoinClient else {
                      result(FlutterError(code: "NATIVE", message: "EstimateTotalFee", details: "parsing arguments"))
                      throw PluginError.invalidArguments
                  }

            let toSendTokenId = TokenId(toSendTokenIdUInt)
            let amount = Amount(toSendAmount, in: toSendTokenId)

            client.estimateTotalFee(toSendAmount: amount) { (estimateTotalFeeResult: Result<UInt64, TransactionEstimationFetcherError>) in
                switch estimateTotalFeeResult {
                case .success(let feeValue):
                    DispatchQueue.main.async {
                        result("\(feeValue)")
                    }
                case .failure(let error):
                    result(FlutterError(code: "NATIVE", message: error.localizedDescription, details: "EstimateTotalFee.estimation"))
                }
            }
        }
    }

    struct CreateProofOfReserveSignedContingentInput: Command {
        func execute(args: [String : Any], result: @escaping FlutterResult) throws {
            guard let mobileClientId: Int = args["id"] as? Int,
                  let txOutPublicKeyBytes: FlutterStandardTypedData = args["txOutPublicKeyBytes"] as? FlutterStandardTypedData else {
                      result(FlutterError(code: "NATIVE", message: "CreateProofOfReserveSignedContingentInput", details: "parsing arguments"))
                      throw PluginError.invalidArguments
                  }

            guard let mobileCoinClient: MobileCoinClient = ObjectStorage.objectForKey(mobileClientId) as? MobileCoinClient else {
                    result(FlutterError(code: "NATIVE", message: "CreateProofOfReserveSignedContingentInput", details: "retrieve client"))
                    throw PluginError.invalidArguments
                }

            mobileCoinClient.createProofOfReserveSignedContingentInput(txOutPubKeyBytes: txOutPublicKeyBytes.data) { (sciResult: Result<SignedContingentInput, SignedContingentInputCreationError>) in
                do {
                    switch sciResult {
                    case .success(let sci):
                        let data = sci.serializedData
                        var jsonObject: [String: Any] = [:]
                        jsonObject["sciProtobufBytes"] = data
                        result(jsonObject)
                    case .failure(let error):
                        result(FlutterError(code: "NATIVE", message: error.localizedDescription, details: "CreateProofOfReserveSignedContingentInput"))
                    }
                } catch let error {
                    result(FlutterError(code: "NATIVE", message: error.localizedDescription, details: "CreateProofOfReserveSignedContingentInput.Exception"))
                }
            }
        }
    }

    struct GetTransferableAmount: Command {
        func execute(args: [String : Any], result: @escaping FlutterResult) throws {
            guard let clientId: Int = args["id"] as? Int,
                  let tokenIdString = args["tokenId"] as? String,
                  let tokenIdUInt = UInt64(tokenIdString),
                  let client = ObjectStorage.objectForKey(clientId) as? MobileCoinClient else {
                      result(FlutterError(code: "NATIVE", message: "getTransferableAmount", details: "parsing arguments"))
                      throw PluginError.invalidArguments
                  }

            let tokenId = TokenId(tokenIdUInt)
            client.amountTransferable(tokenId: tokenId) { (amountTransferableResult: Result<UInt64, BalanceTransferEstimationFetcherError>) in
                switch amountTransferableResult {
                case .success(let amount):
                    DispatchQueue.main.async {
                        result("\(amount)")
                    }
                case .failure(let error):
                    result(FlutterError(code: "NATIVE", message: error.localizedDescription, details: "amountTransferable"))
                }
            }
        }
    }

    struct DefragmentAccount: Command {
        func execute(args: [String : Any], result: @escaping FlutterResult) throws {
            guard let clientId: Int = args["id"] as? Int,
                  let toSendAmountString = args["amount"] as? String,
                  let toSendAmount = UInt64(toSendAmountString),
                  let toSendTokenIdString = args["tokenId"] as? String,
                  let toSendTokenIdUInt = UInt64(toSendTokenIdString),
                  let rngSeedData: FlutterStandardTypedData = args["rngSeed"] as? FlutterStandardTypedData,
                  let shouldWriteRTHMemos = args["shouldWriteRTHMemos"] as? Bool,
                  let client = ObjectStorage.objectForKey(clientId) as? MobileCoinClient else {
                      result(FlutterError(code: "NATIVE", message: "DefragmentAccount", details: "parsing arguments"))
                      throw PluginError.invalidArguments
                  }

            let toSendTokenId = TokenId(toSendTokenIdUInt)
            let amount = Amount(toSendAmount, in: toSendTokenId)
            let rngSeed = RngSeed(rngSeedData.data) ?? RngSeed()

            client.prepareDefragmentationStepTransactions(
                    toSendAmount: amount,
                    recoverableMemo: shouldWriteRTHMemos,
                    rngSeed: rngSeed)
            { (preperationResult: Result<[Transaction], DefragTransactionPreparationError>) in
                switch preperationResult {
                case .success(let stepTransactions):
                    client.submitDefragStepTransactions(
                        transactions: stepTransactions
                    ) { (defragResult: Result<[UInt64], SubmitTransactionError>) in
                        switch defragResult {
                        case .success(let blockIndexes):
                            DispatchQueue.main.async {
                                result(blockIndexes)
                            }
                        case .failure(let error):
                            result(FlutterError(code: "NATIVE", message: error.localizedDescription, details: "DefragAccount.prepareDefragmentationStepTransactions"))
                        }
                    }
                case .failure(let error):
                    result(FlutterError(code: "NATIVE", message: error.localizedDescription, details: "DefragAccount.prepareDefragmentationStepTransactions"))
                }
            }
        }
    }

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
                        let activityDispatchGroup = DispatchGroup()
                        for tokenId in balances.tokenIds {
                            let activity = client.accountActivity(for: tokenId)
                            let txOuts = activity.txOuts
                            var jsonObject: [String: Any] = [:]

                            let balance: UInt64 = balances.balances[tokenId]?.amount() ?? 0
                            jsonObject["balance"] = String(balance)
                            jsonObject["blockCount"] = String(activity.blockCount)
                            activityDispatchGroup.enter()
                            client.amountTransferable(tokenId: tokenId) { (amountTransferableResult: Result<UInt64, BalanceTransferEstimationFetcherError>) in
                                switch amountTransferableResult {
                                    case .success(let amount):
                                        jsonObject["transferableAmount"] = String(amount)
                                        print ("transferableAmount = \(amount)")
                                    case .failure(let error):
                                        switch error {
                                            case .feeExceedsBalance:
                                                jsonObject["transferableAmount"] = String("0")
                                                print ("transferableAmount = \(0)")
                                            default:
                                                result(FlutterError(code: "NATIVE", message: error.localizedDescription, details: "amountTransferable"))
                                        }
                                }
                                activityDispatchGroup.leave()
                            }
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

                                if let memo = transaction.memo {
                                    jsonTxOut["theirAddressHashHex"] = memo.addressHashHex

                                    // Encode memo as JSON == [String:Any]
                                    if let encoded = memo.toDictionary() {
                                        jsonTxOut["memo"] = encoded
                                    }
                                }

                                // Unauthenticated memo's can be used w/o a matching contact/public-address
                                if let unauthenticatedMemo = transaction.unauthenticatedMemo,
                                   let encoded = unauthenticatedMemo.toDictionary() {
                                    // Encode memo as JSON == [String:Any]
                                    // Will overwrite if already set which is ok for now.
                                    jsonTxOut["memo"] = encoded
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
                            activityDispatchGroup.wait()
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
            let memoType: MemoType = {
                            guard
                                let paymentRequestIdString = args["paymentRequestId"] as? String,
                                let paymentRequest = UInt64(paymentRequestIdString)
                            else {
                                return MemoType.recoverable
                            }
                            return MemoType.recoverablePaymentRequest(id: paymentRequest)
                        }()

            guard let recipient: PublicAddress = ObjectStorage.objectForKey(recipientId) as? PublicAddress,
                  let mobileCoinClient: MobileCoinClient = ObjectStorage.objectForKey(mobileClientId) as? MobileCoinClient else {
                      result(FlutterError(code: "NATIVE", message: "CreatePendingTransaction", details: "retrieve client"))
                      throw PluginError.invalidArguments
                  }
            mobileCoinClient.prepareTransaction(to: recipient, memoType: memoType, amount: amount, fee: fee, rng: rng) {
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
        case let .senderWithPaymentIntent(memo):
            return memo.addressHashHex
        case let .sender(memo):
            return memo.addressHashHex
        case let .destinationWithPaymentRequest(memo):
            return memo.addressHashHex
        case let .destinationWithPaymentIntent(memo):
            return memo.addressHashHex
        case let .destination(memo):
            return memo.addressHashHex
        }
    }
}

extension RecoveredMemo {
    func toDictionary() -> [String: Any]? {
        let encoder = DictionaryEncoder()
        let dictionary: Any = {
            switch self {
            case .sender(let memo):
                return try? encoder.encode(memo)
            case .senderWithPaymentRequest(let memo):
                return try? encoder.encode(memo)
            case .senderWithPaymentIntent(let memo):
                return try? encoder.encode(memo)
            case .destination(let memo):
                return try? encoder.encode(memo)
            case .destinationWithPaymentRequest(let memo):
                return try? encoder.encode(memo)
            case .destinationWithPaymentIntent(let memo):
                return try? encoder.encode(memo)
            }
        }()

        return dictionary as? [String: Any]
    }
}

extension UnauthenticatedSenderMemo {
    func toDictionary() -> [String: Any]? {
        let encoder = DictionaryEncoder()
        let dictionary: Any = {
            switch self {
            case .sender(let memo):
                return try? encoder.encode(memo)
            case .senderWithPaymentRequest(let memo):
                return try? encoder.encode(memo)
            case .senderWithPaymentIntent(let memo):
                return try? encoder.encode(memo)
            }
        }()

        return dictionary as? [String: Any]
    }
}

class DictionaryEncoder {
    private let jsonEncoder = JSONEncoder()

    /// Encodes given Encodable value into an array or dictionary
    func encode<T>(_ value: T) throws -> Any where T: Encodable {
        let jsonData = try jsonEncoder.encode(value)
        return try JSONSerialization.jsonObject(with: jsonData, options: .allowFragments)
    }
}

class DictionaryDecoder {
    private let jsonDecoder = JSONDecoder()

    /// Decodes given Decodable type from given array or dictionary
    func decode<T>(_ type: T.Type, from json: Any) throws -> T where T: Decodable {
        let jsonData = try JSONSerialization.data(withJSONObject: json, options: [])
        return try jsonDecoder.decode(type, from: jsonData)
    }
}

public enum HexEncoding {
    static func data(fromHexEncodedString hexEncodedString: String) -> Data? {
        guard hexEncodedString.count.isMultiple(of: 2) else { return nil }
        let byteStrings = hexEncodedString.chunked(maxLength: 2)

        let bytes = byteStrings.compactMap { UInt8($0, radix: 16) }
        guard byteStrings.count == bytes.count else { return nil }

        return Data(bytes)
    }

    private static let hexCharacters = Array("0123456789abcdef")

    static func hexEncodedString(fromData data: Data) -> String {
        data.reduce(into: "") { result, byte in
            result.append(Self.hexCharacters[Int(byte / 0x10)])
            result.append(Self.hexCharacters[Int(byte % 0x10)])
        }
    }
}

extension Collection {
    func chunked(maxLength: Int) -> [SubSequence] {
        var chunks: [SubSequence] = []
        var nextIndex = startIndex
        while true {
            let startIndex = nextIndex
            _ = formIndex(&nextIndex, offsetBy: maxLength, limitedBy: endIndex)
            guard distance(from: startIndex, to: endIndex) > 0 else {
                break
            }
            chunks.append(self[startIndex ..< Swift.min(nextIndex, self.endIndex)])
        }
        return chunks
    }
}
