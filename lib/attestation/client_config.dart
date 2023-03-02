import 'package:mobilecoin_flutter/attestation/service_config.dart';
import 'package:mobilecoin_flutter/mobilecoin.dart';
import 'package:mobilecoin_flutter/platform_object.dart';

class ClientConfig extends PlatformObject {
  ClientConfig(int objectId) : super(id: objectId);
  static Future<ClientConfig> fromServiceConfigs(
      List<ServiceConfig> configs) async {
    final objectId =
        await MobileCoinFlutterPluginChannelApi.instance.createClientConfig();
    for (final config in configs) {
      await MobileCoinFlutterPluginChannelApi.instance.addServiceConfig(
        objectId,
        config,
      );
    }

    return ClientConfig(objectId);
  }
}
