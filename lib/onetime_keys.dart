import 'ristretto_private.dart';
import 'mobilecoin.dart';
import 'platform_object.dart';
import 'ristretto_public.dart';

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
