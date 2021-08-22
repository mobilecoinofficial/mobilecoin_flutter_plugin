import 'dart:async';
import 'dart:developer';
import 'package:mobilecoin_flutter/mobilecoin.dart';

import 'picomob.dart';
import 'public_address.dart';
import 'receipt.dart';

import 'account_key.dart';
import 'platform_object.dart';

class MobileCoinClient extends PlatformObject {
  final AccountKey accountKey;

  MobileCoinClient(this.accountKey, int objectId) : super(id: objectId);

  static Future<MobileCoinClient> create(
      AccountKey accountKey, String fogUrl, String consensusUrl) async {
    final objectId =
        await MobileCoinFlutterPluginChannelApi.instance.createMobileCoinClient(
      accountKey: accountKey,
      fogUrl: fogUrl,
      consensusUrl: consensusUrl,
    );
    return MobileCoinClient(accountKey, objectId);
  }

  Future<Receipt?> sendFunds(
      PublicAddress recipient, PicoMob amount, PicoMob fee) async {
    try {
      final receiptId =
          await MobileCoinFlutterPluginChannelApi.instance.sendFunds(
        mobileClientId: id,
        recipientId: recipient.id,
        fee: fee,
        amount: amount,
      );
      return Receipt(receiptId);
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<BigInt?> getBalance() async {
    try {
      return await MobileCoinFlutterPluginChannelApi.instance
          .getBalance(mobileCoinClientId: id);
    } on Exception {
      return null;
    }
  }

  Future<String?> getAccountActivity() async {
    try {
      return await MobileCoinFlutterPluginChannelApi.instance
          .getAccountActivity(mobileCoinClientId: id);
    } on Exception {
      return null;
    }
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
