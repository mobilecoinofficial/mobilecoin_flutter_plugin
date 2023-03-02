import 'package:flutter_test/flutter_test.dart';
import 'package:mobilecoin_flutter/attestation/service_config.dart';

void main() {
  const fogViewMrEnclave = '1';
  const fogLedgerMrEnclave = '2';
  const fogReportMrEnclave = '3';
  const consensusMrEnclave = '4';
  const hardeningAdvisories = ['INTEL-SA-SOMETHING'];

  const fogViewMrEnclave2 = 'a';
  const fogLedgerMrEnclave2 = 'b';
  const fogReportMrEnclave2 = 'c';
  const consensusMrEnclave2 = 'd';
  const hardeningAdvisories2 = ['INTEL-SA-SOMETHING', 'MORE-OF-THE-SAME'];

  group('Service Config', () {
    test('verify json encoding/decoding', () {
      const originalConfig = ServiceConfig(
        fogViewMrEnclave: fogViewMrEnclave,
        fogLedgerMrEnclave: fogLedgerMrEnclave,
        fogReportMrEnclave: fogReportMrEnclave,
        consensusMrEnclave: consensusMrEnclave,
        hardeningAdvisories: hardeningAdvisories,
      );
      const secondConfig = ServiceConfig(
        fogViewMrEnclave: fogViewMrEnclave2,
        fogLedgerMrEnclave: fogLedgerMrEnclave2,
        fogReportMrEnclave: fogReportMrEnclave2,
        consensusMrEnclave: consensusMrEnclave2,
        hardeningAdvisories: hardeningAdvisories2,
      );

      final configJson = originalConfig.toJson;
      final restoredConfig = ServiceConfig.fromJson(configJson);
      expect(restoredConfig, originalConfig);
      expect(originalConfig, isNot(secondConfig));
    });
  });
}
