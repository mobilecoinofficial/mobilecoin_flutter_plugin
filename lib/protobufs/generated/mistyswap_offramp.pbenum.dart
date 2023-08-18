///
//  Generated code. Do not modify.
//  source: mistyswap_offramp.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

// ignore_for_file: UNDEFINED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class OfframpResultCode extends $pb.ProtobufEnum {
  static const OfframpResultCode ORC_INVALID = OfframpResultCode._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'ORC_INVALID');
  static const OfframpResultCode ORC_OK = OfframpResultCode._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'ORC_OK');
  static const OfframpResultCode ORC_TOO_MANY_OFFRAMPS = OfframpResultCode._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'ORC_TOO_MANY_OFFRAMPS');
  static const OfframpResultCode ORC_MIXIN_CREDENTIALS_JSON = OfframpResultCode._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'ORC_MIXIN_CREDENTIALS_JSON');
  static const OfframpResultCode ORC_OFFRAMP_ALREADY_IN_PROGRESS = OfframpResultCode._(4, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'ORC_OFFRAMP_ALREADY_IN_PROGRESS');
  static const OfframpResultCode ORC_MIXIN = OfframpResultCode._(5, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'ORC_MIXIN');
  static const OfframpResultCode ORC_INVALID_SRC_ASSET_ID = OfframpResultCode._(6, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'ORC_INVALID_SRC_ASSET_ID');
  static const OfframpResultCode ORC_INVALID_DST_ASSET_ID = OfframpResultCode._(7, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'ORC_INVALID_DST_ASSET_ID');
  static const OfframpResultCode ORC_OFFRAMP_ID_NOT_FOUND = OfframpResultCode._(8, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'ORC_OFFRAMP_ID_NOT_FOUND');
  static const OfframpResultCode ORC_INVALID_SRC_EXPECTED_AMOUNT = OfframpResultCode._(9, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'ORC_INVALID_SRC_EXPECTED_AMOUNT');
  static const OfframpResultCode ORC_INVALID_MIN_DST_RECEIVED_AMOUNT = OfframpResultCode._(10, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'ORC_INVALID_MIN_DST_RECEIVED_AMOUNT');
  static const OfframpResultCode ORC_INVALID_MAX_FEE_AMOUNT_IN_DST_TOKENS = OfframpResultCode._(11, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'ORC_INVALID_MAX_FEE_AMOUNT_IN_DST_TOKENS');
  static const OfframpResultCode ORC_INVALID_FEE_TOKEN_SWAP_MULTIPLIER = OfframpResultCode._(12, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'ORC_INVALID_FEE_TOKEN_SWAP_MULTIPLIER');

  static const $core.List<OfframpResultCode> values = <OfframpResultCode> [
    ORC_INVALID,
    ORC_OK,
    ORC_TOO_MANY_OFFRAMPS,
    ORC_MIXIN_CREDENTIALS_JSON,
    ORC_OFFRAMP_ALREADY_IN_PROGRESS,
    ORC_MIXIN,
    ORC_INVALID_SRC_ASSET_ID,
    ORC_INVALID_DST_ASSET_ID,
    ORC_OFFRAMP_ID_NOT_FOUND,
    ORC_INVALID_SRC_EXPECTED_AMOUNT,
    ORC_INVALID_MIN_DST_RECEIVED_AMOUNT,
    ORC_INVALID_MAX_FEE_AMOUNT_IN_DST_TOKENS,
    ORC_INVALID_FEE_TOKEN_SWAP_MULTIPLIER,
  ];

  static final $core.Map<$core.int, OfframpResultCode> _byValue = $pb.ProtobufEnum.initByValue(values);
  static OfframpResultCode? valueOf($core.int value) => _byValue[value];

  const OfframpResultCode._($core.int v, $core.String n) : super(v, n);
}

class OfframpState extends $pb.ProtobufEnum {
  static const OfframpState OS_INVALID = OfframpState._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'OS_INVALID');
  static const OfframpState OS_NOT_STARTED = OfframpState._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'OS_NOT_STARTED');
  static const OfframpState OS_POLLING = OfframpState._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'OS_POLLING');
  static const OfframpState OS_WAITING = OfframpState._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'OS_WAITING');
  static const OfframpState OS_INVALID_WITHDRAWAL_ADDRESS = OfframpState._(4, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'OS_INVALID_WITHDRAWAL_ADDRESS');
  static const OfframpState OS_INTERMITTENT_ERROR = OfframpState._(5, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'OS_INTERMITTENT_ERROR');
  static const OfframpState OS_BLOCKED_ON_SWAP = OfframpState._(6, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'OS_BLOCKED_ON_SWAP');
  static const OfframpState OS_BLOCKED_ON_WITHDRAWAL = OfframpState._(7, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'OS_BLOCKED_ON_WITHDRAWAL');
  static const OfframpState OS_WITHDRAWAL_COMPLETED = OfframpState._(8, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'OS_WITHDRAWAL_COMPLETED');
  static const OfframpState OS_UNRECOVERABLE_ERROR = OfframpState._(9, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'OS_UNRECOVERABLE_ERROR');

  static const $core.List<OfframpState> values = <OfframpState> [
    OS_INVALID,
    OS_NOT_STARTED,
    OS_POLLING,
    OS_WAITING,
    OS_INVALID_WITHDRAWAL_ADDRESS,
    OS_INTERMITTENT_ERROR,
    OS_BLOCKED_ON_SWAP,
    OS_BLOCKED_ON_WITHDRAWAL,
    OS_WITHDRAWAL_COMPLETED,
    OS_UNRECOVERABLE_ERROR,
  ];

  static final $core.Map<$core.int, OfframpState> _byValue = $pb.ProtobufEnum.initByValue(values);
  static OfframpState? valueOf($core.int value) => _byValue[value];

  const OfframpState._($core.int v, $core.String n) : super(v, n);
}

