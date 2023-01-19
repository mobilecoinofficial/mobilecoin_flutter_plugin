import 'dart:typed_data';
import 'mobilecoin.dart';
import 'platform_object.dart';
import 'public_address.dart';
import 'account_key.dart';

class CryptoBox extends PlatformObject {
  CryptoBox(int objectId) : super(id: objectId);

  static Future<Uint8List> encrypt({
    required PublicAddress recipient,
    required Uint8List data,
  }) async {
    return await MobileCoinFlutterPluginChannelApi.instance.cryptoBoxEncrypt(
      recipient: recipient,
      data: data,
    );
  }

  static Future<Uint8List> decrypt({
    required AccountKey accountKey,
    required Uint8List data,
  }) async {
    return await MobileCoinFlutterPluginChannelApi.instance.cryptoBoxDecrypt(
      accountKey: accountKey,
      data: data,
    );
  }
}
