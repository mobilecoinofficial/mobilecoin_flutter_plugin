// Copyright (c) 2021-2024 MobileCoin. All rights reserved.

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:mobilecoin_flutter/src/account_key.dart';
import 'package:mobilecoin_flutter/src/attestation/service_config.dart';
import 'package:mobilecoin_flutter/src/protobufs/generated/mistyswap_common.pb.dart';
import 'package:mobilecoin_flutter/src/protobufs/generated/mistyswap_offramp.pb.dart';
import 'package:mobilecoin_flutter/src/protobufs/generated/mistyswap_onramp.pb.dart';
import 'package:mobilecoin_flutter/src/public_address.dart';
import 'package:mobilecoin_flutter/src/ristretto_private.dart';
import 'package:mobilecoin_flutter/src/ristretto_public.dart';

class MobileCoinFlutterPluginChannelApi {
  static const MethodChannel _methodChannel =
      MethodChannel('mobilecoin_flutter');

  static MobileCoinFlutterPluginChannelApi get instance {
    _instance ??= MobileCoinFlutterPluginChannelApi(_methodChannel);
    return _instance!;
  }

  static MobileCoinFlutterPluginChannelApi? _instance;

  @visibleForTesting
  MobileCoinFlutterPluginChannelApi(this._channel);

  final MethodChannel _channel;

  Future<int> createMobileCoinClient(AccountKey key) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'accountKey': key.id,
      'fogUrl': key.config.fogUrl,
      'consensusUrl': key.config.consensusUrl,
      'mistyswapUrl': key.config.mistyswapUrl,
      'useTestNet': key.config.useTestNet,
      'clientConfigId': key.config.attestClientConfig.id,
    };

    return await _channel.invokeMethod("MobileCoinClient#create", params);
  }

  Future<String> getBalance({required int mobileCoinClientId}) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'id': mobileCoinClientId,
    };
    String balance =
        await _channel.invokeMethod("MobileCoinClient#getBalance", params);
    return balance;
  }

  Future<String> getAccountActivity({
    required int mobileCoinClientId,
    required List<Uint8List> serializedKnownPublicAddresses,
  }) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'id': mobileCoinClientId,
      'serializedPublicAddresses': serializedKnownPublicAddresses,
    };
    String json = await _channel.invokeMethod(
      "MobileCoinClient#getAccountActivity",
      params,
    );
    return json;
  }

  Future<Map<String, Object?>> createPendingTransaction({
    required int mobileClientId,
    required int recipientId,
    required BigInt fee,
    required BigInt amount,
    required BigInt tokenId,
    required String rngSeed,
    BigInt? paymentRequestId,
  }) async {
    if (rngSeed.codeUnits.length != 32) {
      throw Exception(
        '''Invalid rngSeed $rngSeed. Byte length must be 32, but received ${rngSeed.codeUnits.length}''',
      );
    }

    final Map<String, dynamic> params = <String, dynamic>{
      'id': mobileClientId,
      'recipient': recipientId,
      'fee': fee.toString(),
      'amount': amount.toString(),
      'tokenId': tokenId.toString(),
      'rngSeed': Uint8List.fromList(rngSeed.codeUnits),
      'paymentRequestId': paymentRequestId?.toString(),
    };
    final result = await _channel.invokeMethod(
      "MobileCoinClient#createPendingTransaction",
      params,
    );
    return Map<String, Object?>.from(result as Map);
  }

  Future<String> sendFunds({
    required int mobileClientId,
    required Uint8List serializedTransaction,
  }) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'id': mobileClientId,
      'transaction': serializedTransaction,
    };
    final json =
        await _channel.invokeMethod("MobileCoinClient#sendFunds", params);
    return json;
  }

  Future<int> checkTransactionStatus({
    required int mobileClientId,
    required int receiptId,
  }) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'id': mobileClientId,
      'receiptId': receiptId,
    };

    return await _channel.invokeMethod(
      "MobileCoinClient#checkTransactionStatus",
      params,
    );
  }

  ///Set the basic HTTP authorization username and password for future requests
  Future<void> setAuthorization({
    required int mobileClientId,
    required String username,
    required String password,
  }) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'id': mobileClientId,
      'username': username,
      'password': password,
    };
    return await _channel.invokeMethod(
      "MobileCoinClient#setAuthorization",
      params,
    );
  }

  Future<int> getAccountKeyFromBip39Entropy({
    required Uint8List entropy,
    required String fogReportUri,
    required String fogReportId,
    required Uint8List fogAuthoritySpki,
  }) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'bip39Entropy': entropy,
      'fogReportUri': fogReportUri,
      'fogAuthoritySpki': fogAuthoritySpki,
      'reportId': fogReportId,
    };
    return await _channel.invokeMethod("AccountKey#fromBip39Entropy", params);
  }

  Future<int> getAccountKeyPublicAddress({required int accountKeyId}) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'id': accountKeyId,
    };
    return await _channel.invokeMethod("AccountKey#getPublicAddress", params);
  }

  Future<int> printableWrapperFromB58String({
    required String b58String,
  }) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'b58String': b58String,
    };
    return await _channel.invokeMethod(
      "PrintableWrapper#fromB58String",
      params,
    );
  }

  Future<String> printableWrapperToB58String({
    required int printableWrapperId,
  }) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'id': printableWrapperId,
    };
    return await _channel.invokeMethod("PrintableWrapper#toB58String", params);
  }

  Future<bool> printableWrapperHasPublicAddress({
    required int printableWrapperId,
  }) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'id': printableWrapperId,
    };
    return await _channel.invokeMethod(
      "PrintableWrapper#hasPublicAddress",
      params,
    );
  }

  Future<int> printableWrapperGetPublicAddress({
    required int printableWrapperId,
  }) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'id': printableWrapperId,
    };
    return await _channel.invokeMethod(
      "PrintableWrapper#getPublicAddress",
      params,
    );
  }

  Future<int> printableWrapperFromPublicAddress({
    required int publicAddressId,
  }) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'id': publicAddressId,
    };
    return await _channel.invokeMethod(
      "PrintableWrapper#fromPublicAddress",
      params,
    );
  }

  Future<bool> printableWrapperHasTransferPayload({
    required int printableWrapperId,
  }) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'id': printableWrapperId,
    };
    return await _channel.invokeMethod(
      "PrintableWrapper#hasTransferPayload",
      params,
    );
  }

  Future<int> printableWrapperGetTransferPayload({
    required int printableWrapperId,
  }) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'id': printableWrapperId,
    };
    return await _channel.invokeMethod(
      "PrintableWrapper#getTransferPayload",
      params,
    );
  }

  Future<int> printableWrapperFromPaymentRequest({
    required int paymentRequestId,
  }) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'id': paymentRequestId,
    };
    return await _channel.invokeMethod(
      "PrintableWrapper#fromPaymentRequest",
      params,
    );
  }

  Future<bool> printableWrapperHasPaymentRequest({
    required int printableWrapperId,
  }) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'id': printableWrapperId,
    };
    return await _channel.invokeMethod(
      "PrintableWrapper#hasPaymentRequest",
      params,
    );
  }

  Future<int> printableWrapperGetPaymentRequest({
    required int printableWrapperId,
  }) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'id': printableWrapperId,
    };
    return await _channel.invokeMethod(
      "PrintableWrapper#getPaymentRequest",
      params,
    );
  }

  Future<int> printableWrapperFromTransferPayload({
    required int transferPayloadId,
  }) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'id': transferPayloadId,
    };
    return await _channel.invokeMethod(
      "PrintableWrapper#fromTransferPayload",
      params,
    );
  }

  Future<int> publicAddressFromBytes({
    required Uint8List publicAddress,
  }) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'serializedBytes': publicAddress,
    };
    return await _channel.invokeMethod("PublicAddress#fromBytes", params);
  }

  Future<Uint8List> publicAddressToByteArray({
    required int publicAddressId,
  }) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'id': publicAddressId,
    };
    final List<int> serializedBytes =
        await _channel.invokeMethod("PublicAddress#toByteArray", params);
    return Uint8List.fromList(serializedBytes);
  }

  Future<Uint8List> publicAddressGetAddressHash({
    required int publicAddressId,
  }) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'id': publicAddressId,
    };
    final List<int> serializedBytes =
        await _channel.invokeMethod("PublicAddress#getAddressHash", params);
    return Uint8List.fromList(serializedBytes);
  }

  Future<Uint8List> transferPayloadGetBip39Entropy({
    required int transferPayloadId,
  }) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'id': transferPayloadId,
    };
    final List<int> entropy =
        await _channel.invokeMethod("TransferPayload#getBip39Entropy", params);
    return Uint8List.fromList(entropy);
  }

  Future<String> transferPayloadGetMemo({
    required int transferPayloadId,
  }) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'id': transferPayloadId,
    };
    return await _channel.invokeMethod("TransferPayload#getMemo", params);
  }

  Future<int> transferPayloadGetPublicKey({
    required int transferPayloadId,
  }) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'id': transferPayloadId,
    };
    return await _channel.invokeMethod("TransferPayload#getPublicKey", params);
  }

  Future<int> paymentRequestCreate({
    required PublicAddress publicAddress,
    required BigInt tokenId,
    String? memo,
    BigInt? amount,
  }) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'publicAddressId': publicAddress.id,
      'memo': memo,
      'amount': amount?.toString(),
      'tokenId': tokenId.toString(),
    };
    return await _channel.invokeMethod("PaymentRequest#create", params);
  }

  Future<String?> paymentRequestGetMemo({
    required int paymentRequestId,
  }) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'id': paymentRequestId,
    };
    return await _channel.invokeMethod("PaymentRequest#getMemo", params);
  }

  Future<BigInt> paymentRequestGetValue({
    required int paymentRequestId,
  }) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'id': paymentRequestId,
    };
    String valueString =
        await _channel.invokeMethod("PaymentRequest#getValue", params);
    return BigInt.parse(valueString);
  }

  Future<BigInt> paymentRequestGetTokenId({
    required int paymentRequestId,
  }) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'id': paymentRequestId,
    };
    String tokenIdString =
        await _channel.invokeMethod("PaymentRequest#getTokenId", params);
    return BigInt.parse(tokenIdString);
  }

  Future<int> paymentRequestGetPublicAddress({
    required int paymentRequestId,
  }) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'id': paymentRequestId,
    };
    return await _channel.invokeMethod(
      "PaymentRequest#getPublicAddress",
      params,
    );
  }

  Future<String> mnemonicFromBip39Entropy(Uint8List entropy) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'bip39Entropy': entropy,
    };
    return await _channel.invokeMethod(
      "Mnemonic#fromBip39Entropy",
      params,
    );
  }

  Future<Uint8List> mnemonicToBip39Entropy(String mnemonicPhrase) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'mnemonicPhrase': mnemonicPhrase,
    };
    final entropy = await _channel.invokeMethod(
      'Mnemonic#toBip39Entropy',
      params,
    );
    return Uint8List.fromList(entropy);
  }

  Future<String> mnemonicAllWords() async {
    final Map<String, dynamic> params = <String, dynamic>{};
    return await _channel.invokeMethod(
      'Mnemonic#allWords',
      params,
    );
  }

  Future<int> createClientConfig() async {
    final Map<String, dynamic> params = <String, dynamic>{};
    return await _channel.invokeMethod(
      "ClientConfig#create",
      params,
    );
  }

  Future<void> addServiceConfig(
    int clientConfigId,
    ServiceConfig serviceConfig,
  ) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'clientConfigId': clientConfigId,
      ServiceConfig.fogViewMrEnclaveKey: serviceConfig.fogViewMrEnclave,
      ServiceConfig.fogLedgerMrEnclaveKey: serviceConfig.fogLedgerMrEnclave,
      ServiceConfig.fogReportMrEnclaveKey: serviceConfig.fogReportMrEnclave,
      ServiceConfig.consensusMrEnclaveKey: serviceConfig.consensusMrEnclave,
      ServiceConfig.mistyswapMrEnclaveKey: serviceConfig.mistyswapMrEnclave,
      ServiceConfig.hardeningAdvisoriesKey:
          serviceConfig.hardeningAdvisories.join(','),
    };
    await _channel.invokeMethod(
      "ClientConfig#addServiceConfig",
      params,
    );
  }

  Future<Uint8List> cryptoBoxEncrypt({
    required RistrettoPublic publicKey,
    required Uint8List data,
  }) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'publicKeyId': publicKey.id,
      'data': data,
    };
    return await _channel.invokeMethod(
      'CryptoBox#encrypt',
      params,
    );
  }

  Future<Uint8List> cryptoBoxDecrypt({
    required RistrettoPrivate privateKey,
    required Uint8List data,
  }) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'privateKeyId': privateKey.id,
      'data': data,
    };
    return await _channel.invokeMethod(
      'CryptoBox#decrypt',
      params,
    );
  }

  Future<bool> accountRequiresDefragmentation({
    required int mobileCoinClientId,
    required BigInt tokenId,
    required BigInt amount,
  }) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'id': mobileCoinClientId,
      'amount': amount.toString(),
      'tokenId': tokenId.toString(),
    };
    return await _channel.invokeMethod(
      "MobileCoinClient#requiresDefragmentation",
      params,
    );
  }

  Future<void> defragmentAccount({
    required int mobileCoinClientId,
    required BigInt tokenId,
    required BigInt amount,
    required bool shouldWriteRTHMemos,
    String? rngSeed,
  }) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'id': mobileCoinClientId,
      'amount': amount.toString(),
      'tokenId': tokenId.toString(),
      'shouldWriteRTHMemos': shouldWriteRTHMemos,
      'rngSeed': (null != rngSeed)
          ? Uint8List.fromList(
              rngSeed.codeUnits,
            )
          : Uint8List.fromList(List.empty()),
    };
    return await _channel.invokeMethod(
      "MobileCoinClient#defragmentAccount",
      params,
    );
  }

  Future<BigInt> estimateTotalFee({
    required int mobileCoinClientId,
    required BigInt tokenId,
    required BigInt amount,
  }) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'id': mobileCoinClientId,
      'amount': amount.toString(),
      'tokenId': tokenId.toString(),
    };
    return BigInt.parse(
      await _channel.invokeMethod(
        "MobileCoinClient#estimateTotalFee",
        params,
      ),
    );
  }

  Future<BigInt> getTransferableAmount({
    required int mobileCoinClientId,
    required BigInt tokenId,
  }) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'id': mobileCoinClientId,
      'tokenId': tokenId.toString(),
    };
    return BigInt.parse(
      await _channel.invokeMethod(
        "MobileCoinClient#getTransferableAmount",
        params,
      ),
    );
  }

  Future<int> ristrettoPublicFromBytes({
    required Uint8List publicKeyBytes,
  }) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'serializedBytes': publicKeyBytes,
    };
    return await _channel.invokeMethod("RistrettoPublic#fromBytes", params);
  }

  Future<Uint8List> ristrettoPublicToByteArray({
    required int ristrettoPublicId,
  }) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'id': ristrettoPublicId,
    };
    final List<int> serializedBytes =
        await _channel.invokeMethod("RistrettoPublic#toByteArray", params);
    return Uint8List.fromList(serializedBytes);
  }

  Future<int> ristrettoPrivateFromBytes({
    required Uint8List privateKeyBytes,
  }) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'serializedBytes': privateKeyBytes,
    };
    return await _channel.invokeMethod("RistrettoPrivate#fromBytes", params);
  }

  Future<Uint8List> ristrettoPrivateToByteArray({
    required int ristrettoPrivateId,
  }) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'id': ristrettoPrivateId,
    };
    final List<int> serializedBytes =
        await _channel.invokeMethod("RistrettoPrivate#toByteArray", params);
    return Uint8List.fromList(serializedBytes);
  }

  Future<int> createTxOutPublicKey({
    required int txOutPrivateKeyId,
    required int recipientSpendPublicKeyId,
  }) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'txOutPrivateKeyId': txOutPrivateKeyId,
      'recipientSpendPublicKeyId': recipientSpendPublicKeyId,
    };
    return await _channel.invokeMethod(
      "OnetimeKeys#createTxOutPublicKey",
      params,
    );
  }

  Future<InitiateOfframpResponse> attestedMistySwapClientInitiateOfframp({
    required int mobileCoinClientId,
    required InitiateOfframpRequest initiateOfframpRequest,
  }) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'mobileCoinClientId': mobileCoinClientId,
      'initiateOfframpRequestBytes': initiateOfframpRequest.writeToBuffer(),
    };
    return InitiateOfframpResponse.fromBuffer(
      await _channel.invokeMethod(
        "AttestedMistySwapClient#initiateOfframp",
        params,
      ),
    );
  }

  Future<ForgetOfframpResponse> attestedMistySwapClientForgetOfframp({
    required int mobileCoinClientId,
    required ForgetOfframpRequest forgetOfframpRequest,
  }) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'mobileCoinClientId': mobileCoinClientId,
      'forgetOfframpRequestBytes': forgetOfframpRequest.writeToBuffer(),
    };
    return ForgetOfframpResponse.fromBuffer(
      await _channel.invokeMethod(
        "AttestedMistySwapClient#forgetOfframp",
        params,
      ),
    );
  }

  Future<GetOfframpStatusResponse> attestedMistySwapClientGetOfframpStatus({
    required int mobileCoinClientId,
    required GetOfframpStatusRequest getOfframpStatusRequest,
  }) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'mobileCoinClientId': mobileCoinClientId,
      'getOfframpStatusRequestBytes': getOfframpStatusRequest.writeToBuffer(),
    };
    return GetOfframpStatusResponse.fromBuffer(
      await _channel.invokeMethod(
        "AttestedMistySwapClient#getOfframpStatus",
        params,
      ),
    );
  }

  Future<GetOfframpDebugInfoResponse>
      attestedMistySwapClientGetOfframpDebugInfo({
    required int mobileCoinClientId,
    required GetOfframpDebugInfoRequest getOfframpDebugInfoRequest,
  }) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'mobileCoinClientId': mobileCoinClientId,
      'getOfframpDebugInfoRequestBytes':
          getOfframpDebugInfoRequest.writeToBuffer(),
    };
    return GetOfframpDebugInfoResponse.fromBuffer(
      await _channel.invokeMethod(
        "AttestedMistySwapClient#getOfframpDebugInfo",
        params,
      ),
    );
  }

  Future<SetupOnrampResponse> attestedMistySwapClientSetupOnramp({
    required int mobileCoinClientId,
    required SetupOnrampRequest setupOnrampRequest,
  }) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'mobileCoinClientId': mobileCoinClientId,
      'setupOnrampRequestBytes': setupOnrampRequest.writeToBuffer(),
    };
    return SetupOnrampResponse.fromBuffer(
      await _channel.invokeMethod(
        "AttestedMistySwapClient#setupOnramp",
        params,
      ),
    );
  }

  Future<ForgetOnrampResponse> attestedMistySwapClientForgetOnramp({
    required int mobileCoinClientId,
    required ForgetOnrampRequest forgetOnrampRequest,
  }) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'mobileCoinClientId': mobileCoinClientId,
      'forgetOnrampRequestBytes': forgetOnrampRequest.writeToBuffer(),
    };
    return ForgetOnrampResponse.fromBuffer(
      await _channel.invokeMethod(
        "AttestedMistySwapClient#forgetOnramp",
        params,
      ),
    );
  }

  Future<GetOnrampStatusResponse> attestedMistySwapClientGetOnrampStatus({
    required int mobileCoinClientId,
    required GetOnrampStatusRequest getOnrampStatusRequest,
  }) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'mobileCoinClientId': mobileCoinClientId,
      'getOnrampStatusRequestBytes': getOnrampStatusRequest.writeToBuffer(),
    };
    return GetOnrampStatusResponse.fromBuffer(
      await _channel.invokeMethod(
        "AttestedMistySwapClient#getOnrampStatus",
        params,
      ),
    );
  }

  Future<GetOnrampDebugInfoResponse> attestedMistySwapClientGetOnrampDebugInfo({
    required int mobileCoinClientId,
    required GetOnrampDebugInfoRequest getOnrampDebugInfoRequest,
  }) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'mobileCoinClientId': mobileCoinClientId,
      'getOnrampDebugInfoRequestBytes':
          getOnrampDebugInfoRequest.writeToBuffer(),
    };
    return GetOnrampDebugInfoResponse.fromBuffer(
      await _channel.invokeMethod(
        "AttestedMistySwapClient#getOnrampDebugInfo",
        params,
      ),
    );
  }

  Future<GetInfoResponse> attestedMistySwapClientGetInfo({
    required int mobileCoinClientId,
  }) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'mobileCoinClientId': mobileCoinClientId,
    };
    return GetInfoResponse.fromBuffer(
      await _channel.invokeMethod(
        "AttestedMistySwapClient#getInfoResponse",
        params,
      ),
    );
  }
}
