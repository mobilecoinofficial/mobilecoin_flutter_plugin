import 'package:mobilecoin_flutter/mobilecoin.dart';
import 'package:mobilecoin_flutter/platform_object.dart';
import 'package:mobilecoin_flutter/ristretto_private.dart';
import 'package:mobilecoin_flutter/ristretto_public.dart';

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
