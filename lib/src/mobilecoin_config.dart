import 'dart:typed_data';

import 'package:mobilecoin_flutter/mobilecoin_flutter.dart';

class MobileCoinConfig {
  final String fogUrl;
  final String consensusUrl;
  final ClientConfig attestClientConfig;
  final Uint8List fogAuthoritySpki;
  final String fogReportId;

  /// The budget for one whole HTTP transfer, start to finish.
  ///
  /// Null leaves the platform's own budget in place, which on iOS is 300
  /// seconds. Raise it for users whose accounts are heavy enough, or whose
  /// links slow enough, that a single fog response can still be arriving
  /// when the budget runs out: one cut-off round trip fails the whole scan,
  /// and the wallet then serves the balance from whenever a scan last
  /// succeeded. Whether a transfer is alive at all remains the idle
  /// timeout's judgement; this only gives a slow live one room to finish.
  ///
  /// Android ignores it. Its SDK exposes no equivalent setting.
  final Duration? fogResourceTimeout;

  const MobileCoinConfig({
    required this.fogUrl,
    required this.consensusUrl,
    required this.attestClientConfig,
    required this.fogAuthoritySpki,
    required this.fogReportId,
    this.fogResourceTimeout,
  }) : assert(
          fogResourceTimeout == null || fogResourceTimeout > Duration.zero,
          'fogResourceTimeout must be positive',
        );
}
