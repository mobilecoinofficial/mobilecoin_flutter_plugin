import 'dart:typed_data';

import 'package:mobilecoin_flutter/mobilecoin_flutter.dart';

class MobileCoinConfig {
  final String fogUrl;
  final String consensusUrl;
  final ClientConfig attestClientConfig;
  final Uint8List fogAuthoritySpki;
  final String fogReportId;

  /// Seconds of budget for one whole HTTP transfer, start to finish.
  ///
  /// Null leaves the iOS default of 300 in place. Raise it for users whose
  /// accounts are heavy enough, or whose links slow enough, that a single
  /// fog response can still be arriving when the budget runs out: one
  /// cut-off round trip fails the whole scan, and the wallet then serves
  /// the balance from whenever a scan last succeeded.
  /// Whether a transfer is alive at all remains the idle timeout's
  /// judgement; this only gives a slow live one room to finish.
  ///
  /// The name carries the platform because only iOS reads it: the Android
  /// SDK exposes no equivalent setting for it to reach.
  final int? iosFogResourceTimeoutSeconds;

  const MobileCoinConfig({
    required this.fogUrl,
    required this.consensusUrl,
    required this.attestClientConfig,
    required this.fogAuthoritySpki,
    required this.fogReportId,
    this.iosFogResourceTimeoutSeconds,
  }) : assert(
          iosFogResourceTimeoutSeconds == null ||
              iosFogResourceTimeoutSeconds > 0,
          'iosFogResourceTimeoutSeconds must be positive',
        );
}
