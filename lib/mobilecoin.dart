import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:mobilecoin_flutter/public_address.dart';

import 'account_key.dart';
import 'picomob.dart';

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

  Future<String> getAccountActivity({required int mobileCoinClientId}) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'id': mobileCoinClientId,
    };
    String json = await _channel.invokeMethod(
        "MobileCoinClient#getAccountActivity", params);
    return json;
  }

  Future<Map<String, Object?>> createPendingTransaction({
    required int mobileClientId,
    required int recipientId,
    required PicoMob fee,
    required PicoMob amount,
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
      'fee': fee.picoCountAsString(),
      'amount': amount.picoCountAsString(),
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
    String? memo,
    PicoMob? amount,
  }) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'publicAddressId': publicAddress.id,
      'memo': memo,
      'amount': amount?.picoCountAsString(),
    };
    return await _channel.invokeMethod("PaymentRequest#create", params);
  }

  Future<String> paymentRequestGetMemo({
    required int transferPayloadId,
  }) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'id': transferPayloadId,
    };
    return await _channel.invokeMethod("PaymentRequest#getMemo", params);
  }

  Future<BigInt> paymentRequestGetValue({
    required int transferPayloadId,
  }) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'id': transferPayloadId,
    };
    String valueString =
        await _channel.invokeMethod("PaymentRequest#getValue", params);
    return BigInt.parse(valueString);
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
      "Mnemonic#toBip39Entropy",
      params,
    );
    return Uint8List.fromList(entropy);
  }

  Future<String> mnemonicAllWords() async {
    final Map<String, dynamic> params = <String, dynamic>{};
    return await _channel.invokeMethod(
      "Mnemonic#allWords",
      params,
    );
  }
}
