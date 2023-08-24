import 'package:mobilecoin_flutter/src/mobilecoin_flutter_plugin_channel_api.dart';
import 'package:mobilecoin_flutter/src/platform_object.dart';
import 'package:mobilecoin_flutter/src/ristretto_private.dart';
import 'package:mobilecoin_flutter/src/ristretto_public.dart';

class OnetimeKeys extends PlatformObject {
  OnetimeKeys(int objectId) : super(id: objectId);

  static Future<RistrettoPublic> createTxOutPublicKey({
    required RistrettoPrivate txOutPrivateKey,
    required RistrettoPublic recipientSpendPublicKey,
  }) async {
    final objectId =
        await MobileCoinFlutterPluginChannelApi.instance.createTxOutPublicKey(
      txOutPrivateKeyId: txOutPrivateKey.id,
      recipientSpendPublicKeyId: recipientSpendPublicKey.id,
    );
    return RistrettoPublic(objectId);
  }
}
