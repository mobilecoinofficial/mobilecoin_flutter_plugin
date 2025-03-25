import 'dart:typed_data';

import 'package:mobilecoin_flutter/mobilecoin_flutter.dart';

class MobileCoinConfig {
  final String fogUrl;
  final String consensusUrl;
  final bool useTestNet;
  final ClientConfig attestClientConfig;
  final String mistyswapUrl;
  final Uint8List fogAuthoritySpki;
  final String fogReportId;

  const MobileCoinConfig({
    required this.fogUrl,
    required this.consensusUrl,
    required this.useTestNet,
    required this.attestClientConfig,
    required this.mistyswapUrl,
    required this.fogAuthoritySpki,
    required this.fogReportId,
  });
}
