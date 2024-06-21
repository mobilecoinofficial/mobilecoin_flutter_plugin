// Copyright (c) 2021-2024 MobileCoin. All rights reserved.

import 'package:mobilecoin_flutter/src/attestation/service_config.dart';
import 'package:mobilecoin_flutter/src/mobilecoin_flutter_plugin_channel_api.dart';
import 'package:mobilecoin_flutter/src/platform_object.dart';

class ClientConfig extends PlatformObject {
  ClientConfig(int objectId) : super(id: objectId);
  static Future<ClientConfig> fromServiceConfigs(
    List<ServiceConfig> configs,
  ) async {
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
