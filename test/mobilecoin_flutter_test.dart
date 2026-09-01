// Copyright (c) 2021-2024 MobileCoin. All rights reserved.

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobilecoin_flutter/src/mobilecoin_flutter_plugin_channel_api.dart';

void main() {
  const MethodChannel channel = MethodChannel('mobilecoin_flutter');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (_) async => '42');
  });

  test("constructs channel api", () async {
    expect(MobileCoinFlutterPluginChannelApi.instance, isNotNull);
  });

  group('getTxOutPublicKeys', () {
    // 32 ASCII characters, so codeUnits are the bytes the seed stands for.
    const seed = 'abcdefghijklmnopqrstuvwxyz012345';

    test('sends the seed as 32 raw bytes with the recipient', () async {
      late MethodCall sent;
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(channel, (call) async {
        sent = call;
        return <Object?, Object?>{};
      });

      await MobileCoinFlutterPluginChannelApi.instance.getTxOutPublicKeys(
        mobileClientId: 3,
        recipientId: 5,
        rngSeed: seed,
      );

      expect(sent.method, 'MobileCoinClient#getTxOutPublicKeys');
      expect(sent.arguments, {
        'id': 3,
        'recipient': 5,
        // The bytes must match what createPendingTransaction sends for the same
        // seed, or the keys reported here name no transaction the send builds.
        'rngSeed': Uint8List.fromList(seed.codeUnits),
      });
    });

    test('returns the keys the platform answers with', () async {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(channel, (_) async {
        // A method channel hands back an untyped map, not a typed one.
        return <Object?, Object?>{
          'payloadTxOutPublicKey': 'abc',
          'changeTxOutPublicKey': 'def',
        };
      });

      final keys =
          await MobileCoinFlutterPluginChannelApi.instance.getTxOutPublicKeys(
        mobileClientId: 1,
        recipientId: 2,
        rngSeed: seed,
      );

      expect(keys, {
        'payloadTxOutPublicKey': 'abc',
        'changeTxOutPublicKey': 'def',
      });
    });

    test('rejects a seed that is not 32 bytes without calling native',
        () async {
      var invoked = false;
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(channel, (_) async {
        invoked = true;
        return <Object?, Object?>{};
      });

      await expectLater(
        () => MobileCoinFlutterPluginChannelApi.instance.getTxOutPublicKeys(
          mobileClientId: 1,
          recipientId: 2,
          rngSeed: 'too-short',
        ),
        throwsA(isA<Exception>()),
      );

      // A substituted seed would name keys no transaction carries, so the
      // seed must never reach native unchecked.
      expect(invoked, isFalse);
    });
  });
}
