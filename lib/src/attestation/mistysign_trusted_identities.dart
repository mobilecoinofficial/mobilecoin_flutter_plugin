// Copyright (c) 2021-2026 MobileCoin. All rights reserved.

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

/// A trusted enclave measurement to verify a Mistysign attestation against.
@immutable
class MistysignMrEnclave extends Equatable {
  const MistysignMrEnclave({
    required this.mrEnclave,
    this.hardeningAdvisories = const [],
    this.configAdvisories = const [],
  });

  final String mrEnclave;
  final List<String> hardeningAdvisories;
  final List<String> configAdvisories;

  Map<String, Object?> get toChannelMap => {
        'mrEnclave': mrEnclave,
        'hardeningAdvisories': hardeningAdvisories.join(','),
        'configAdvisories': configAdvisories.join(','),
      };

  @override
  List<Object?> get props => [
        mrEnclave,
        hardeningAdvisories,
        configAdvisories,
      ];
}

/// A trusted signer measurement to verify a Mistysign attestation against.
@immutable
class MistysignMrSigner extends Equatable {
  const MistysignMrSigner({
    required this.mrSigner,
    required this.productId,
    required this.minimumSecurityVersion,
    this.hardeningAdvisories = const [],
    this.configAdvisories = const [],
  });

  final String mrSigner;
  final int productId;
  final int minimumSecurityVersion;
  final List<String> hardeningAdvisories;
  final List<String> configAdvisories;

  Map<String, Object?> get toChannelMap => {
        'mrSigner': mrSigner,
        'productId': productId,
        'minimumSecurityVersion': minimumSecurityVersion,
        'hardeningAdvisories': hardeningAdvisories.join(','),
        'configAdvisories': configAdvisories.join(','),
      };

  @override
  List<Object?> get props => [
        mrSigner,
        productId,
        minimumSecurityVersion,
        hardeningAdvisories,
        configAdvisories,
      ];
}
