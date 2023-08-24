import 'dart:typed_data';

import 'package:mobilecoin_flutter/src/mobilecoin_flutter_plugin_channel_api.dart';
import 'package:mobilecoin_flutter/src/platform_object.dart';
import 'package:mobilecoin_flutter/src/ristretto_private.dart';
import 'package:mobilecoin_flutter/src/ristretto_public.dart';

class CryptoBox extends PlatformObject {
  CryptoBox(int objectId) : super(id: objectId);

  static Future<Uint8List> encrypt({
    required RistrettoPublic publicKey,
    required Uint8List data,
  }) async {
    return await MobileCoinFlutterPluginChannelApi.instance.cryptoBoxEncrypt(
      publicKey: publicKey,
      data: data,
    );
  }

  static Future<Uint8List> decrypt({
    required RistrettoPrivate privateKey,
    required Uint8List data,
  }) async {
    return await MobileCoinFlutterPluginChannelApi.instance.cryptoBoxDecrypt(
      privateKey: privateKey,
      data: data,
    );
  }
}
