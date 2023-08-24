import 'dart:typed_data';

import 'package:mobilecoin_flutter/src/mobilecoin_flutter_plugin_channel_api.dart';
import 'package:mobilecoin_flutter/src/platform_object.dart';

class RistrettoPublic extends PlatformObject {
  RistrettoPublic(int objectId) : super(id: objectId);

  static Future<RistrettoPublic> fromBytes(Uint8List serializedBytes) async {
    final objectId = await MobileCoinFlutterPluginChannelApi.instance
        .ristrettoPublicFromBytes(publicKeyBytes: serializedBytes);
    return RistrettoPublic(objectId);
  }

  Future<Uint8List> toByteArray() async {
    return await MobileCoinFlutterPluginChannelApi.instance
        .ristrettoPublicToByteArray(ristrettoPublicId: id);
  }
}
