import 'dart:async';
import 'dart:typed_data';

import 'mobilecoin.dart';
import 'account_key.dart';
import 'platform_object.dart';
import 'public_address.dart';

class MobileCoinClient extends PlatformObject {
  final AccountKey accountKey;

  MobileCoinClient(this.accountKey, int objectId) : super(id: objectId);

  static Future<MobileCoinClient> create(
    AccountKey accountKey,
    String fogUrl,
    String consensusUrl,
    bool useTestNet,
  ) async {
    final objectId =
        await MobileCoinFlutterPluginChannelApi.instance.createMobileCoinClient(
      accountKey: accountKey,
      fogUrl: fogUrl,
      consensusUrl: consensusUrl,
      useTestNet: useTestNet,
    );
    return MobileCoinClient(accountKey, objectId);
  }

  Future<Map<String, Object?>> createPendingTransaction(
    PublicAddress recipient,
    BigInt amount,
    BigInt fee,
    BigInt tokenId,
    String rngSeed,
  ) async {
    return await MobileCoinFlutterPluginChannelApi.instance
        .createPendingTransaction(
      mobileClientId: id,
      recipientId: recipient.id,
      fee: fee,
      amount: amount,
      tokenId: tokenId,
      rngSeed: rngSeed,
    );
  }

  Future<String> sendFunds(Uint8List serializedTransaction) async {
    return await MobileCoinFlutterPluginChannelApi.instance.sendFunds(
      mobileClientId: id,
      serializedTransaction: serializedTransaction,
    );
  }

  Future<int> checkTransactionStatus(int receiptId) async {
    final result =
        await MobileCoinFlutterPluginChannelApi.instance.checkTransactionStatus(
      mobileClientId: id,
      receiptId: receiptId,
    );
    return result;
  }

  Future<String> getBalance() async {
    return await MobileCoinFlutterPluginChannelApi.instance
        .getBalance(mobileCoinClientId: id);
  }

  /// Gets activity associated with the current client as a JSON string.
  ///
  /// [serializedKnownPublicAddresses] used for reading RTH memos.
  /// When supplied, it returns hashed public addresses of a transaction's
  /// opposite party, which mitigates strangers looking up addresses that
  /// they don't have the hash of.
  /// The best way to supply it is with [PublicAddress.toByteArray].
  /// Because of the async nature of that call, the consumer will likely
  /// want to cache those serialized addresses.
  Future<String> getAccountActivity(
    List<Uint8List> serializedKnownPublicAddresses,
  ) async {
    return await MobileCoinFlutterPluginChannelApi.instance.getAccountActivity(
      mobileCoinClientId: id,
      serializedKnownPublicAddresses: serializedKnownPublicAddresses,
    );
  }

  /// Set the basic HTTP authorization username and password for future requests.
  Future<void> setAuthorization({
    required String username,
    required String password,
  }) async {
    return await MobileCoinFlutterPluginChannelApi.instance.setAuthorization(
      mobileClientId: id,
      username: username,
      password: password,
    );
  }
}
