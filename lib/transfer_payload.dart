import 'dart:typed_data';
import 'mobilecoin.dart';
import 'ristretto_public.dart';
import 'platform_object.dart';

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
