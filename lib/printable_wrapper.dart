import 'package:mobilecoin_flutter/mobilecoin.dart';
import 'package:mobilecoin_flutter/payment_request.dart';
import 'package:mobilecoin_flutter/public_address.dart';
import 'package:mobilecoin_flutter/transfer_payload.dart';

import 'platform_object.dart';

class PrintableWrapper extends PlatformObject {
  PrintableWrapper(int objectId) : super(id: objectId);

  static Future<PrintableWrapper> fromB58String(String b58String) async {
    final objectId = await MobileCoinFlutterPluginChannelApi.instance
        .printableWrapperFromB58String(b58String: b58String);
    return PrintableWrapper(objectId);
  }

  Future<String> toB58String() async {
    return await MobileCoinFlutterPluginChannelApi.instance
        .printableWrapperToB58String(printableWrapperId: id);
  }

  static Future<PrintableWrapper> fromPublicAddress(
      PublicAddress publicAddress) async {
    final objectId = await MobileCoinFlutterPluginChannelApi.instance
        .printableWrapperFromPublicAddress(publicAddressId: publicAddress.id);
    return PrintableWrapper(objectId);
  }

  Future<bool> hasPublicAddress() async {
    return await MobileCoinFlutterPluginChannelApi.instance
        .printableWrapperHasPublicAddress(printableWrapperId: id);
  }

  Future<PublicAddress> getPublicAddress() async {
    final objectId = await MobileCoinFlutterPluginChannelApi.instance
        .printableWrapperGetPublicAddress(printableWrapperId: id);
    return PublicAddress(objectId);
  }

  static Future<PrintableWrapper> fromTransferPayload(
      TransferPayload transferPayload) async {
    final objectId = await MobileCoinFlutterPluginChannelApi.instance
        .printableWrapperFromTransferPayload(
            transferPayloadId: transferPayload.id);
    return PrintableWrapper(objectId);
  }

  Future<bool> hasTransferPayload() async {
    return await MobileCoinFlutterPluginChannelApi.instance
        .printableWrapperHasTransferPayload(printableWrapperId: id);
  }

  Future<TransferPayload> getTransferPayload() async {
    final objectId = await MobileCoinFlutterPluginChannelApi.instance
        .printableWrapperGetTransferPayload(printableWrapperId: id);
    return TransferPayload(objectId);
  }

  Future<bool> hasPaymentRequest() async {
    return await MobileCoinFlutterPluginChannelApi.instance
        .printableWrapperHasPaymentRequest(printableWrapperId: id);
  }

  Future<PaymentRequest> getPaymentRequest() async {
    final objectId = await MobileCoinFlutterPluginChannelApi.instance
        .printableWrapperGetPaymentRequest(printableWrapperId: id);
    return PaymentRequest(objectId);
  }
}
