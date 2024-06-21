// Copyright (c) 2021-2024 MobileCoin. All rights reserved.

import 'dart:typed_data';

import 'package:mobilecoin_flutter/src/mobilecoin_flutter_plugin_channel_api.dart';
import 'package:mobilecoin_flutter/src/platform_object.dart';

class RistrettoPrivate extends PlatformObject {
  RistrettoPrivate(int objectId) : super(id: objectId);

  static Future<RistrettoPrivate> fromBytes(Uint8List serializedBytes) async {
    final objectId = await MobileCoinFlutterPluginChannelApi.instance
        .ristrettoPrivateFromBytes(privateKeyBytes: serializedBytes);
    return RistrettoPrivate(objectId);
  }

  Future<Uint8List> toByteArray() async {
    return await MobileCoinFlutterPluginChannelApi.instance
        .ristrettoPrivateToByteArray(ristrettoPrivateId: id);
  }
}
