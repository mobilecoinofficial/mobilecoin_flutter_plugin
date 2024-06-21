// Copyright (c) 2021-2024 MobileCoin. All rights reserved.

import 'dart:typed_data';

import 'package:mobilecoin_flutter/src/mobilecoin_flutter_plugin_channel_api.dart';
import 'package:mobilecoin_flutter/src/platform_object.dart';

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
