import 'dart:typed_data';

import 'package:mobilecoin_flutter/src/mobilecoin_flutter_plugin_channel_api.dart';
import 'package:mobilecoin_flutter/src/platform_object.dart';
import 'package:mobilecoin_flutter/src/public_address.dart';

class AccountKey extends PlatformObject {
  PublicAddress? _publicAddress;
  Uint8List bip39Entropy;
  Uint8List fogAuthoritySpki;
  String fogReportUri;
  String reportId;

  AccountKey(
    int objectId,
    this.bip39Entropy,
    this.fogReportUri,
    this.fogAuthoritySpki,
    this.reportId,
  ) : super(id: objectId);

  static Future<AccountKey> fromBip39Entropy(
    Uint8List entropy,
    String fogReportUri, {
    required Uint8List fogAuthoritySpki,
    required String reportId,
  }) async {
    final objectId = await MobileCoinFlutterPluginChannelApi.instance
        .getAccountKeyFromBip39Entropy(
      entropy: entropy,
      fogReportUri: fogReportUri,
      fogAuthoritySpki: fogAuthoritySpki,
      reportId: reportId,
    );
    return AccountKey(
      objectId,
      entropy,
      fogReportUri,
      fogAuthoritySpki,
      reportId,
    );
  }

  Future<PublicAddress> getPublicAddress() async {
    if (null == _publicAddress) {
      final objectId = await MobileCoinFlutterPluginChannelApi.instance
          .getAccountKeyPublicAddress(accountKeyId: id);
      _publicAddress = PublicAddress(objectId);
    }
    return _publicAddress!;
  }
}
