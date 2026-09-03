// Copyright (c) 2021-2024 MobileCoin. All rights reserved.

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobilecoin_flutter/src/mobilecoin_client.dart';
import 'package:mobilecoin_flutter/src/mobilecoin_flutter_plugin_channel_api.dart';
import 'package:mobilecoin_flutter/src/public_address.dart';

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

    test('returns the raw map the platform answers with', () async {
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
      var wasInvoked = false;
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(channel, (_) async {
        wasInvoked = true;
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
      expect(wasInvoked, isFalse);
    });

    test('rejects a 32-character seed that is not 32 bytes', () async {
      var wasInvoked = false;
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(channel, (_) async {
        wasInvoked = true;
        return <Object?, Object?>{};
      });

      await expectLater(
        () => MobileCoinFlutterPluginChannelApi.instance.getTxOutPublicKeys(
          mobileClientId: 1,
          recipientId: 2,
          // Counts as 32 code units, but the last one does not fit in a byte
          // and would be truncated to bytes the caller never meant.
          rngSeed: 'abcdefghijklmnopqrstuvwxyz01234\u0100',
        ),
        throwsA(isA<Exception>()),
      );

      expect(wasInvoked, isFalse);
    });

    test('sends the same seed bytes createPendingTransaction does', () async {
      final sent = <String, Object?>{};
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(channel, (call) async {
        sent[call.method] =
            (call.arguments as Map<Object?, Object?>)['rngSeed'];
        return <Object?, Object?>{};
      });

      await MobileCoinFlutterPluginChannelApi.instance.getTxOutPublicKeys(
        mobileClientId: 1,
        recipientId: 2,
        rngSeed: seed,
      );
      await MobileCoinFlutterPluginChannelApi.instance.createPendingTransaction(
        mobileClientId: 1,
        recipientId: 2,
        fee: BigInt.one,
        amount: BigInt.two,
        tokenId: BigInt.zero,
        rngSeed: seed,
      );

      // The derived keys only describe the later send while both calls reach
      // the same stream, which they do only from identical seed bytes.
      expect(
        sent['MobileCoinClient#getTxOutPublicKeys'],
        sent['MobileCoinClient#createPendingTransaction'],
      );
    });
  });

  group('MobileCoinFlutterClient.getTxOutPublicKeys', () {
    const seed = 'abcdefghijklmnopqrstuvwxyz012345';

    test('reports the two keys as a record', () async {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(channel, (_) async {
        return <Object?, Object?>{
          'payloadTxOutPublicKey': 'abc',
          'changeTxOutPublicKey': 'def',
        };
      });

      final keys = await MobileCoinFlutterClient(1).getTxOutPublicKeys(
        recipient: PublicAddress(2),
        rngSeed: seed,
      );

      expect(keys.payload, 'abc');
      expect(keys.change, 'def');
    });

    test('throws when the platform answers without both keys', () async {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(channel, (_) async {
        // Reporting one key as the other's value would seal a key the
        // transaction never carries, so a partial answer is not usable.
        return <Object?, Object?>{'payloadTxOutPublicKey': 'abc'};
      });

      await expectLater(
        () => MobileCoinFlutterClient(1).getTxOutPublicKeys(
          recipient: PublicAddress(2),
          rngSeed: seed,
        ),
        throwsA(isA<StateError>()),
      );
    });
  });
}
