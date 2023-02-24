import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'public_address.dart';
import 'account_key.dart';

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

  Future<int> createMobileCoinClient({
    required AccountKey accountKey,
    required String fogUrl,
    required String consensusUrl,
    required bool useTestNet,
  }) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'accountKey': accountKey.id,
      'fogUrl': fogUrl,
      'consensusUrl': consensusUrl,
      'useTestNet': useTestNet,
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
        "MobileCoinClient#getAccountActivity", params);
    return json;
  }

  Future<Map<String, Object?>> createPendingTransaction({
    required int mobileClientId,
    required int recipientId,
    required BigInt fee,
    required BigInt amount,
    required BigInt tokenId,
    required String rngSeed,
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
        "MobileCoinClient#checkTransactionStatus", params);
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
        "MobileCoinClient#setAuthorization", params);
  }

  Future<int> getAccountKeyFromBip39Entropy({
    required Uint8List entropy,
    required String fogReportUri,
    required String reportId,
    required Uint8List fogAuthoritySpki,
  }) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'bip39Entropy': entropy,
      'fogReportUri': fogReportUri,
      'fogAuthoritySpki': fogAuthoritySpki,
      'reportId': reportId,
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
        "PrintableWrapper#fromB58String", params);
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
        "PrintableWrapper#hasPublicAddress", params);
  }

  Future<int> printableWrapperGetPublicAddress({
    required int printableWrapperId,
  }) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'id': printableWrapperId,
    };
    return await _channel.invokeMethod(
        "PrintableWrapper#getPublicAddress", params);
  }

  Future<int> printableWrapperFromPublicAddress({
    required int publicAddressId,
  }) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'id': publicAddressId,
    };
    return await _channel.invokeMethod(
        "PrintableWrapper#fromPublicAddress", params);
  }

  Future<bool> printableWrapperHasTransferPayload({
    required int printableWrapperId,
  }) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'id': printableWrapperId,
    };
    return await _channel.invokeMethod(
        "PrintableWrapper#hasTransferPayload", params);
  }

  Future<int> printableWrapperGetTransferPayload({
    required int printableWrapperId,
  }) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'id': printableWrapperId,
    };
    return await _channel.invokeMethod(
        "PrintableWrapper#getTransferPayload", params);
  }

  Future<int> printableWrapperFromPaymentRequest({
    required int paymentRequestId,
  }) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'id': paymentRequestId,
    };
    return await _channel.invokeMethod(
        "PrintableWrapper#fromPaymentRequest", params);
  }

  Future<bool> printableWrapperHasPaymentRequest({
    required int printableWrapperId,
  }) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'id': printableWrapperId,
    };
    return await _channel.invokeMethod(
        "PrintableWrapper#hasPaymentRequest", params);
  }

  Future<int> printableWrapperGetPaymentRequest({
    required int printableWrapperId,
  }) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'id': printableWrapperId,
    };
    return await _channel.invokeMethod(
        "PrintableWrapper#getPaymentRequest", params);
  }

  Future<int> printableWrapperFromTransferPayload({
    required int transferPayloadId,
  }) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'id': transferPayloadId,
    };
    return await _channel.invokeMethod(
        "PrintableWrapper#fromTransferPayload", params);
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

  Future<Uint8List> transferPayloadGetBip39Entropy(
      {required int transferPayloadId}) async {
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

  Future<int> transferPayloadGetPublicKey(
      {required int transferPayloadId}) async {
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

  Future<int> paymentRequestGetPublicAddress(
      {required int paymentRequestId}) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'id': paymentRequestId,
    };
    return await _channel.invokeMethod(
        "PaymentRequest#getPublicAddress", params);
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

  Future<Uint8List> cryptoBoxEncrypt({
    required PublicAddress recipient,
    required Uint8List data,
  }) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'publicAddressId': recipient.id,
      'data': data,
    };
    return await _channel.invokeMethod(
      'CryptoBox#encrypt',
      params,
    );
  }

  Future<Uint8List> cryptoBoxDecrypt({
    required AccountKey accountKey,
    required Uint8List data,
  }) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'accountKeyId': accountKey.id,
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
}
