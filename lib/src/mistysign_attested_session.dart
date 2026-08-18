// Copyright (c) 2021-2026 MobileCoin. All rights reserved.

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:mobilecoin_flutter/src/attestation/mistysign_trusted_identities.dart';
import 'package:mobilecoin_flutter/src/mobilecoin_flutter_plugin_channel_api.dart';
import 'package:mobilecoin_flutter/src/platform_object.dart';

/// An attested channel to a Mistysign enclave whose transport the caller owns.
///
/// The caller relays the handshake and encrypted messages to the enclave
/// itself, this class only performs the handshake and the message
/// encryption. android-sdk has no equivalent yet, so every constructor call
/// throws [UnsupportedError] on Android.
class MistysignAttestedSession extends PlatformObject {
  MistysignAttestedSession(int objectId) : super(id: objectId);

  static Future<MistysignAttestedSession> create() async {
    if (defaultTargetPlatform != TargetPlatform.iOS) {
      throw UnsupportedError(
        'MistysignAttestedSession is not supported on this platform.',
      );
    }

    final objectId = await MobileCoinFlutterPluginChannelApi.instance
        .mistysignAttestedSessionCreate();
    return MistysignAttestedSession(objectId);
  }

  /// Begins the handshake and returns the bytes to relay to the enclave's
  /// Auth RPC.
  Future<Uint8List> authBeginRequestData({required String responderId}) {
    return _wrap(
      () => MobileCoinFlutterPluginChannelApi.instance
          .mistysignAttestedSessionAuthBeginRequestData(
        objectId: id,
        responderId: responderId,
      ),
    );
  }

  /// Completes the handshake with the enclave's Auth RPC response, verifying
  /// its evidence against the given trusted identities.
  Future<void> authEnd({
    required Uint8List authResponseData,
    List<MistysignMrEnclave> mrEnclaves = const [],
    List<MistysignMrSigner> mrSigners = const [],
  }) {
    return _wrap(
      () => MobileCoinFlutterPluginChannelApi.instance
          .mistysignAttestedSessionAuthEnd(
        objectId: id,
        authResponseData: authResponseData,
        mrEnclaves: mrEnclaves,
        mrSigners: mrSigners,
      ),
    );
  }

  /// Encrypts a serialized request proto and returns the bytes to relay to
  /// the enclave.
  Future<Uint8List> encrypt(Uint8List plaintext) {
    return _wrap(
      () => MobileCoinFlutterPluginChannelApi.instance
          .mistysignAttestedSessionEncrypt(objectId: id, plaintext: plaintext),
    );
  }

  /// Decrypts a relayed enclave reply and returns the serialized response
  /// proto.
  Future<Uint8List> decrypt(Uint8List messageData) {
    return _wrap(
      () => MobileCoinFlutterPluginChannelApi.instance
          .mistysignAttestedSessionDecrypt(
        objectId: id,
        messageData: messageData,
      ),
    );
  }

  /// Discards the attested state so a fresh handshake can be started.
  Future<void> deattest() {
    return _wrap(
      () => MobileCoinFlutterPluginChannelApi.instance
          .mistysignAttestedSessionDeattest(objectId: id),
    );
  }

  Future<bool> get isAttested {
    return _wrap(
      () => MobileCoinFlutterPluginChannelApi.instance
          .mistysignAttestedSessionIsAttested(objectId: id),
    );
  }

  /// Releases the native session. The instance must not be used afterwards.
  Future<void> destroy() {
    return _wrap(
      () => MobileCoinFlutterPluginChannelApi.instance
          .mistysignAttestedSessionDestroy(objectId: id),
    );
  }

  Future<T> _wrap<T>(Future<T> Function() call) async {
    try {
      return await call();
    } on PlatformException catch (exception) {
      throw MistysignAttestedSessionException.fromPlatformException(
        exception,
      );
    }
  }
}

enum MistysignAttestedSessionErrorCode {
  notAttested,
  noTrustedIdentities,
  attestationFailed,
  encryptionFailed,
  decryptionFailed,
  unknown,
}

/// A typed failure from [MistysignAttestedSession], discriminated by
/// [code] so callers can react without matching on message strings.
class MistysignAttestedSessionException implements Exception {
  const MistysignAttestedSessionException(this.code, this.message);

  factory MistysignAttestedSessionException.fromPlatformException(
    PlatformException exception,
  ) {
    const codesByChannelCode = {
      'MISTYSIGN_NOT_ATTESTED': MistysignAttestedSessionErrorCode.notAttested,
      'MISTYSIGN_NO_TRUSTED_IDENTITIES':
          MistysignAttestedSessionErrorCode.noTrustedIdentities,
      'MISTYSIGN_ATTESTATION_FAILED':
          MistysignAttestedSessionErrorCode.attestationFailed,
      'MISTYSIGN_ENCRYPTION_FAILED':
          MistysignAttestedSessionErrorCode.encryptionFailed,
      'MISTYSIGN_DECRYPTION_FAILED':
          MistysignAttestedSessionErrorCode.decryptionFailed,
    };

    return MistysignAttestedSessionException(
      codesByChannelCode[exception.code] ??
          MistysignAttestedSessionErrorCode.unknown,
      exception.message,
    );
  }

  final MistysignAttestedSessionErrorCode code;
  final String? message;

  @override
  String toString() => 'MistysignAttestedSessionException($code, $message)';
}
