// Copyright (c) 2021-2024 MobileCoin. All rights reserved.

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class ServiceConfig extends Equatable {
  const ServiceConfig({
    required this.fogViewMrEnclave,
    required this.fogLedgerMrEnclave,
    required this.fogReportMrEnclave,
    required this.consensusMrEnclave,
    required this.hardeningAdvisories,
    this.mistyswapMrEnclave,
  });
  final String fogViewMrEnclave;
  final String fogLedgerMrEnclave;
  final String fogReportMrEnclave;
  final String consensusMrEnclave;
  final String? mistyswapMrEnclave;
  final List<String> hardeningAdvisories;

  static const String fogViewMrEnclaveKey = 'fogViewMrEnclave';
  static const String fogLedgerMrEnclaveKey = 'fogLedgerMrEnclave';
  static const String fogReportMrEnclaveKey = 'fogReportMrEnclave';
  static const String consensusMrEnclaveKey = 'consensusMrEnclave';
  static const String mistyswapMrEnclaveKey = 'mistyswapMrEnclave';
  static const String hardeningAdvisoriesKey = 'hardeningAdvisories';

  static ServiceConfig fromJson(Map<String, dynamic> json) {
    return ServiceConfig(
      fogViewMrEnclave: json[fogViewMrEnclaveKey] as String,
      fogLedgerMrEnclave: json[fogLedgerMrEnclaveKey] as String,
      fogReportMrEnclave: json[fogReportMrEnclaveKey] as String,
      consensusMrEnclave: json[consensusMrEnclaveKey] as String,
      hardeningAdvisories: json[hardeningAdvisoriesKey] as List<String>,
      mistyswapMrEnclave: json[mistyswapMrEnclaveKey] as String?,
    );
  }

  Map<String, Object?> get toJson {
    if (mistyswapMrEnclave != null) {
      return {
        fogViewMrEnclaveKey: fogViewMrEnclave,
        fogLedgerMrEnclaveKey: fogLedgerMrEnclave,
        fogReportMrEnclaveKey: fogReportMrEnclave,
        consensusMrEnclaveKey: consensusMrEnclave,
        hardeningAdvisoriesKey: hardeningAdvisories,
        mistyswapMrEnclaveKey: mistyswapMrEnclave,
      };
    } else {
      return {
        fogViewMrEnclaveKey: fogViewMrEnclave,
        fogLedgerMrEnclaveKey: fogLedgerMrEnclave,
        fogReportMrEnclaveKey: fogReportMrEnclave,
        consensusMrEnclaveKey: consensusMrEnclave,
        hardeningAdvisoriesKey: hardeningAdvisories,
      };
    }
  }

  @override
  List<Object?> get props => [
        fogViewMrEnclave,
        fogLedgerMrEnclave,
        fogReportMrEnclave,
        consensusMrEnclave,
        mistyswapMrEnclave,
      ];
}
