import 'dart:typed_data';
import 'mobilecoin.dart';
import 'platform_object.dart';

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
