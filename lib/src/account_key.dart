// Copyright (c) 2021-2024 MobileCoin. All rights reserved.

import 'dart:typed_data';

import 'package:mobilecoin_flutter/src/mobilecoin_flutter_plugin_channel_api.dart';
import 'package:mobilecoin_flutter/src/platform_object.dart';
import 'package:mobilecoin_flutter/src/public_address.dart';

class AccountKey extends PlatformObject {
  final PublicAddress publicAddress;
  final Uint8List bip39Entropy;
  final Uint8List fogAuthoritySpki;
  final String fogReportUri;
  final String reportId;

  const AccountKey(
    int objectId,
    this.bip39Entropy,
    this.fogReportUri,
    this.fogAuthoritySpki,
    this.reportId,
    this.publicAddress,
  ) : super(id: objectId);

  static Future<AccountKey> fromBip39Entropy(
    Uint8List entropy,
    String fogReportUri, {
    required Uint8List fogAuthoritySpki,
    required String reportId,
  }) async {
    final accountObjectId = await MobileCoinFlutterPluginChannelApi.instance
        .getAccountKeyFromBip39Entropy(
      entropy: entropy,
      fogReportUri: fogReportUri,
      fogAuthoritySpki: fogAuthoritySpki,
      reportId: reportId,
    );
    final publicKeyObjectId = await MobileCoinFlutterPluginChannelApi.instance
        .getAccountKeyPublicAddress(accountKeyId: accountObjectId);

    return AccountKey(
      accountObjectId,
      entropy,
      fogReportUri,
      fogAuthoritySpki,
      reportId,
      PublicAddress(publicKeyObjectId),
    );
  }
}
