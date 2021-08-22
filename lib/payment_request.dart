import 'package:mobilecoin_flutter/mobilecoin.dart';
import 'package:mobilecoin_flutter/public_address.dart';

import 'platform_object.dart';

class PaymentRequest extends PlatformObject {
  PaymentRequest(int objectId) : super(id: objectId);

  Future<PublicAddress> getPublicAddress() async {
    final objectId = await MobileCoinFlutterPluginChannelApi.instance
        .paymentRequestGetPublicAddress(paymentRequestId: id);
    return PublicAddress(objectId);
  }

  Future<BigInt> getValue() async {
    return await MobileCoinFlutterPluginChannelApi.instance
        .paymentRequestGetValue(transferPayloadId: id);
  }

  Future<String?> getMemo() async {
    return await MobileCoinFlutterPluginChannelApi.instance
        .paymentRequestGetMemo(transferPayloadId: id);
  }
}
