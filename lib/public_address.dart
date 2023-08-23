import 'dart:typed_data';

import 'package:mobilecoin_flutter/mobilecoin.dart';
import 'package:mobilecoin_flutter/platform_object.dart';

class PublicAddress extends PlatformObject {
  PublicAddress(int objectId) : super(id: objectId);

  static Future<PublicAddress> fromBytes(Uint8List serializedBytes) async {
    final objectId = await MobileCoinFlutterPluginChannelApi.instance
        .publicAddressFromBytes(publicAddress: serializedBytes);
    return PublicAddress(objectId);
  }

  Future<Uint8List> toByteArray() async {
    return await MobileCoinFlutterPluginChannelApi.instance
        .publicAddressToByteArray(publicAddressId: id);
  }

  Future<Uint8List> getAddressHash() async {
    return await MobileCoinFlutterPluginChannelApi.instance
        .publicAddressGetAddressHash(publicAddressId: id);
  }
}
