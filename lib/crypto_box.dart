import 'dart:typed_data';
import 'ristretto_private.dart';
import 'mobilecoin.dart';
import 'platform_object.dart';
import 'ristretto_public.dart';

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
