// Copyright (c) 2021-2026 MobileCoin. All rights reserved.

import 'package:flutter_test/flutter_test.dart';
import 'package:mobilecoin_flutter/mobilecoin_flutter.dart';

void main() {
  group('MistysignMrEnclave', () {
    test('equal instances compare equal and serialize identically', () {
      const first = MistysignMrEnclave(
        mrEnclave: 'ab',
        hardeningAdvisories: ['INTEL-SA-SOMETHING'],
      );
      const second = MistysignMrEnclave(
        mrEnclave: 'ab',
        hardeningAdvisories: ['INTEL-SA-SOMETHING'],
      );
      const different = MistysignMrEnclave(mrEnclave: 'cd');

      expect(first, second);
      expect(first, isNot(different));
      expect(first.toChannelMap, {
        'mrEnclave': 'ab',
        'hardeningAdvisories': 'INTEL-SA-SOMETHING',
        'configAdvisories': '',
      });
    });
  });

  group('MistysignMrSigner', () {
    test('equal instances compare equal and serialize identically', () {
      const first = MistysignMrSigner(
        mrSigner: 'ab',
        productId: 1,
        minimumSecurityVersion: 2,
        configAdvisories: ['CONFIG-ADVISORY'],
      );
      const second = MistysignMrSigner(
        mrSigner: 'ab',
        productId: 1,
        minimumSecurityVersion: 2,
        configAdvisories: ['CONFIG-ADVISORY'],
      );
      const differentVersion = MistysignMrSigner(
        mrSigner: 'ab',
        productId: 1,
        minimumSecurityVersion: 3,
      );

      expect(first, second);
      expect(first, isNot(differentVersion));
      expect(first.toChannelMap, {
        'mrSigner': 'ab',
        'productId': 1,
        'minimumSecurityVersion': 2,
        'hardeningAdvisories': '',
        'configAdvisories': 'CONFIG-ADVISORY',
      });
    });
  });
}
