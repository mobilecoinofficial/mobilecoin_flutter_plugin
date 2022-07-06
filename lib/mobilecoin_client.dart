import 'dart:async';

import 'package:mobilecoin_flutter/mobilecoin.dart';

import 'account_key.dart';
import 'picomob.dart';
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

  Future<String> createPendingTransaction(
    PublicAddress recipient,
    PicoMob amount,
    PicoMob fee,
  ) async {
    return await MobileCoinFlutterPluginChannelApi.instance
        .createPendingTransaction(
      mobileClientId: id,
      recipientId: recipient.id,
      fee: fee,
      amount: amount,
    );
  }

  Future<String> sendFunds(int pendingTransactionId) async {
    return await MobileCoinFlutterPluginChannelApi.instance.sendFunds(
      mobileClientId: id,
      pendingTransactionId: pendingTransactionId,
    );
  }

  Future<int> checkTransactionStatus(
    int transactionId,
  ) async {
    final result = await MobileCoinFlutterPluginChannelApi.instance
        .checkTransactionStatus(
            mobileClientId: id, transactionId: transactionId);
    return result;
  }

  Future<BigInt> getBalance() async {
    return await MobileCoinFlutterPluginChannelApi.instance
        .getBalance(mobileCoinClientId: id);
  }

  Future<String> getAccountActivity() async {
    return await MobileCoinFlutterPluginChannelApi.instance
        .getAccountActivity(mobileCoinClientId: id);
  }

  ///Set the basic HTTP authorization username and password for future requests
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
