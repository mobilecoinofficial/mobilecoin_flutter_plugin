// Copyright (c) 2021-2024 MobileCoin. All rights reserved.

import 'dart:typed_data';

import 'package:mobilecoin_flutter/src/mobilecoin_flutter_plugin_channel_api.dart';
import 'package:mobilecoin_flutter/src/platform_object.dart';
import 'package:mobilecoin_flutter/src/ristretto_public.dart';

class TransferPayload extends PlatformObject {
  TransferPayload(int objectId) : super(id: objectId);

  Future<Uint8List> getBip39Entropy() async {
    return await MobileCoinFlutterPluginChannelApi.instance
        .transferPayloadGetBip39Entropy(transferPayloadId: id);
  }

  Future<String> getMemo() async {
    return await MobileCoinFlutterPluginChannelApi.instance
        .transferPayloadGetMemo(transferPayloadId: id);
  }

  Future<RistrettoPublic> getPublicKey() async {
    final objectId = await MobileCoinFlutterPluginChannelApi.instance
        .transferPayloadGetPublicKey(transferPayloadId: id);
    return RistrettoPublic(objectId);
  }
}
