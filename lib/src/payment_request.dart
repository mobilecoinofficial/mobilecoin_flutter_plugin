// Copyright (c) 2021-2024 MobileCoin. All rights reserved.

import 'package:mobilecoin_flutter/src/mobilecoin_flutter_plugin_channel_api.dart';
import 'package:mobilecoin_flutter/src/platform_object.dart';
import 'package:mobilecoin_flutter/src/public_address.dart';

class PaymentRequest extends PlatformObject {
  PaymentRequest(int objectId) : super(id: objectId);

  static Future<PaymentRequest> fromPublicAddress({
    required PublicAddress publicAddress,
    required BigInt tokenId,
    String? memo,
    BigInt? amount,
  }) async {
    final objectId =
        await MobileCoinFlutterPluginChannelApi.instance.paymentRequestCreate(
      publicAddress: publicAddress,
      memo: memo,
      amount: amount,
      tokenId: tokenId,
    );
    return PaymentRequest(objectId);
  }

  Future<PublicAddress> getPublicAddress() async {
    final objectId = await MobileCoinFlutterPluginChannelApi.instance
        .paymentRequestGetPublicAddress(paymentRequestId: id);
    return PublicAddress(objectId);
  }

  Future<BigInt> getValue() async {
    return await MobileCoinFlutterPluginChannelApi.instance
        .paymentRequestGetValue(paymentRequestId: id);
  }

  Future<String?> getMemo() async {
    return await MobileCoinFlutterPluginChannelApi.instance
        .paymentRequestGetMemo(paymentRequestId: id);
  }

  Future<BigInt> getTokenId() async {
    return await MobileCoinFlutterPluginChannelApi.instance
        .paymentRequestGetTokenId(paymentRequestId: id);
  }
}
