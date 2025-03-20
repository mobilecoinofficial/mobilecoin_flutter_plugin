// Copyright (c) 2021-2024 MobileCoin. All rights reserved.

import 'dart:typed_data';

import 'package:mobilecoin_flutter/mobilecoin_flutter.dart';
import 'package:mobilecoin_flutter/src/mobilecoin_flutter_plugin_channel_api.dart';
import 'package:mobilecoin_flutter/src/platform_object.dart';

class AccountKey extends PlatformObject {
  final String publicAddress;
  final Uint8List publicAddressHash;
  final Uint8List bip39Entropy;
  final List<String> mnemonicPhrase;
  final MobileCoinConfig config;

  const AccountKey(
    int objectId, {
    required this.bip39Entropy,
    required this.mnemonicPhrase,
    required this.publicAddress,
    required this.publicAddressHash,
    required this.config,
  }) : super(id: objectId);

  static Future<AccountKey> fromBip39Entropy(
    Uint8List entropy,
    MobileCoinConfig config,
  ) async {
    final accountObjectId = await MobileCoinFlutterPluginChannelApi.instance
        .getAccountKeyFromBip39Entropy(
      entropy: entropy,
      fogReportUri: config.fogUrl,
      fogAuthoritySpki: config.fogAuthoritySpki,
      fogReportId: config.fogReportId,
    );
    final publicKeyObjectId = await MobileCoinFlutterPluginChannelApi.instance
        .getAccountKeyPublicAddress(accountKeyId: accountObjectId);

    final printableWrapper = await PrintableWrapper.fromPublicAddress(
      PublicAddress(publicKeyObjectId),
    );

    return AccountKey(
      accountObjectId,
      bip39Entropy: entropy,
      publicAddress: await printableWrapper.toB58String(),
      publicAddressHash:
          await (await printableWrapper.getPublicAddress()).getAddressHash(),
      config: config,
      mnemonicPhrase: (await MobileCoinFlutterPluginChannelApi.instance
              .mnemonicFromBip39Entropy(entropy))
          .split(' '),
    );
  }
}
