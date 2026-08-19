// Copyright (c) 2021-2026 MobileCoin. All rights reserved.

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobilecoin_flutter/mobilecoin_flutter.dart';

void main() {
  const channel = MethodChannel('mobilecoin_flutter');

  TestWidgetsFlutterBinding.ensureInitialized();

  tearDown(() {
    debugDefaultTargetPlatformOverride = null;
  });

  group('on Android', () {
    setUp(() {
      debugDefaultTargetPlatformOverride = TargetPlatform.android;
    });

    test('create returns a session backed by the native object id', () async {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(channel, (call) async {
        expect(call.method, 'MistysignAttestedSession#create');
        return 11;
      });

      final session = await MistysignAttestedSession.create();

      expect(session.id, 11);
    });
  });

  group('on an unsupported platform', () {
    setUp(() {
      debugDefaultTargetPlatformOverride = TargetPlatform.linux;
    });

    test('create throws UnsupportedError', () {
      expect(
        MistysignAttestedSession.create,
        throwsA(isA<UnsupportedError>()),
      );
    });
  });

  group('on iOS', () {
    setUp(() {
      debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
    });

    test('create returns a session backed by the native object id', () async {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(channel, (call) async {
        expect(call.method, 'MistysignAttestedSession#create');
        return 7;
      });

      final session = await MistysignAttestedSession.create();

      expect(session.id, 7);
    });

    test('authBeginRequestData relays the responder id and returns bytes',
        () async {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(channel, (call) async {
        expect(call.method, 'MistysignAttestedSession#authBeginRequestData');
        expect(call.arguments['id'], 1);
        expect(call.arguments['responderId'], 'enclave-1');
        return Uint8List.fromList([1, 2, 3]);
      });

      final session = MistysignAttestedSession(1);
      final result =
          await session.authBeginRequestData(responderId: 'enclave-1');

      expect(result, Uint8List.fromList([1, 2, 3]));
    });

    test('authBeginRequestData rejects an empty responder id', () async {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(channel, (call) async {
        fail('the channel should not have been reached');
      });

      // The iOS SDK treats the native handshake as infallible and traps the
      // process on an empty responder id, so nothing may reach the channel.
      expect(
        () => MistysignAttestedSession(1).authBeginRequestData(responderId: ''),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('authEnd sends the trusted identities as channel maps', () async {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(channel, (call) async {
        expect(call.method, 'MistysignAttestedSession#authEnd');
        expect(call.arguments['mrEnclaves'], [
          {
            'mrEnclave': 'ab',
            'hardeningAdvisories': 'INTEL-SA-SOMETHING',
            'configAdvisories': '',
          }
        ]);
        expect(call.arguments['mrSigners'], [
          {
            'mrSigner': 'cd',
            'productId': 1,
            'minimumSecurityVersion': 2,
            'hardeningAdvisories': '',
            'configAdvisories': 'CONFIG-ADVISORY',
          }
        ]);
        return null;
      });

      final session = MistysignAttestedSession(1);
      await session.authEnd(
        authResponseData: Uint8List.fromList([4, 5, 6]),
        mrEnclaves: const [
          MistysignMrEnclave(
            mrEnclave: 'ab',
            hardeningAdvisories: ['INTEL-SA-SOMETHING'],
          ),
        ],
        mrSigners: const [
          MistysignMrSigner(
            mrSigner: 'cd',
            productId: 1,
            minimumSecurityVersion: 2,
            configAdvisories: ['CONFIG-ADVISORY'],
          ),
        ],
      );
    });

    test('encrypt returns the ciphertext bytes', () async {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(channel, (call) async {
        expect(call.method, 'MistysignAttestedSession#encrypt');
        return Uint8List.fromList([9]);
      });

      final session = MistysignAttestedSession(1);
      final result = await session.encrypt(Uint8List.fromList([1]));

      expect(result, Uint8List.fromList([9]));
    });

    test('decrypt returns the plaintext bytes', () async {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(channel, (call) async {
        expect(call.method, 'MistysignAttestedSession#decrypt');
        return Uint8List.fromList([1]);
      });

      final session = MistysignAttestedSession(1);
      final result = await session.decrypt(Uint8List.fromList([9]));

      expect(result, Uint8List.fromList([1]));
    });

    test('isAttested reflects the native handshake state', () async {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(channel, (call) async {
        expect(call.method, 'MistysignAttestedSession#isAttested');
        return true;
      });

      final session = MistysignAttestedSession(1);

      expect(await session.isAttested, isTrue);
    });

    test('deattest and destroy call through the channel', () async {
      final invokedMethods = <String>[];
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(channel, (call) async {
        invokedMethods.add(call.method);
        return null;
      });

      final session = MistysignAttestedSession(1);
      await session.deattest();
      await session.destroy();

      expect(invokedMethods, [
        'MistysignAttestedSession#deattest',
        'MistysignAttestedSession#destroy',
      ]);
    });

    for (final entry in {
      'MISTYSIGN_NOT_ATTESTED': MistysignAttestedSessionErrorCode.notAttested,
      'MISTYSIGN_NO_TRUSTED_IDENTITIES':
          MistysignAttestedSessionErrorCode.noTrustedIdentities,
      'MISTYSIGN_INVALID_TRUSTED_IDENTITY':
          MistysignAttestedSessionErrorCode.invalidTrustedIdentity,
      'MISTYSIGN_ATTESTATION_FAILED':
          MistysignAttestedSessionErrorCode.attestationFailed,
      'MISTYSIGN_ENCRYPTION_FAILED':
          MistysignAttestedSessionErrorCode.encryptionFailed,
      'MISTYSIGN_DECRYPTION_FAILED':
          MistysignAttestedSessionErrorCode.decryptionFailed,
      'UNKNOWN_CODE': MistysignAttestedSessionErrorCode.unknown,
    }.entries) {
      test('maps channel code ${entry.key} to ${entry.value}', () async {
        TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
            .setMockMethodCallHandler(channel, (call) async {
          throw PlatformException(code: entry.key, message: 'boom');
        });

        final session = MistysignAttestedSession(1);

        await expectLater(
          session.encrypt(Uint8List.fromList([1])),
          throwsA(
            isA<MistysignAttestedSessionException>()
                .having((e) => e.code, 'code', entry.value),
          ),
        );
      });
    }
  });
}
