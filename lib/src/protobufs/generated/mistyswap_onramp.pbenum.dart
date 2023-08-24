///
//  Generated code. Do not modify.
//  source: mistyswap_onramp.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

// ignore_for_file: UNDEFINED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class OnrampResultCode extends $pb.ProtobufEnum {
  static const OnrampResultCode ORC_INVALID = OnrampResultCode._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'ORC_INVALID');
  static const OnrampResultCode ORC_OK = OnrampResultCode._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'ORC_OK');
  static const OnrampResultCode ORC_TOO_MANY_ONRAMPS = OnrampResultCode._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'ORC_TOO_MANY_ONRAMPS');
  static const OnrampResultCode ORC_MIXIN_CREDENTIALS_JSON = OnrampResultCode._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'ORC_MIXIN_CREDENTIALS_JSON');
  static const OnrampResultCode ORC_CREDENTIALS_ALREADY_IN_USE = OnrampResultCode._(4, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'ORC_CREDENTIALS_ALREADY_IN_USE');
  static const OnrampResultCode ORC_MIXIN = OnrampResultCode._(5, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'ORC_MIXIN');
  static const OnrampResultCode ORC_ONRAMP_NOT_FOUND = OnrampResultCode._(6, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'ORC_ONRAMP_NOT_FOUND');
  static const OnrampResultCode ORC_INVALID_SRC_ASSET_ID = OnrampResultCode._(7, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'ORC_INVALID_SRC_ASSET_ID');
  static const OnrampResultCode ORC_INVALID_DST_ASSET_ID = OnrampResultCode._(8, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'ORC_INVALID_DST_ASSET_ID');
  static const OnrampResultCode ORC_INVALID_WITHDRAWAL_ADDRESS = OnrampResultCode._(9, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'ORC_INVALID_WITHDRAWAL_ADDRESS');
  static const OnrampResultCode ORC_INVALID_MIN_WITHDRAWAL_AMOUNT = OnrampResultCode._(10, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'ORC_INVALID_MIN_WITHDRAWAL_AMOUNT');
  static const OnrampResultCode ORC_INVALID_MIN_SWAP_RATE = OnrampResultCode._(11, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'ORC_INVALID_MIN_SWAP_RATE');

  static const $core.List<OnrampResultCode> values = <OnrampResultCode> [
    ORC_INVALID,
    ORC_OK,
    ORC_TOO_MANY_ONRAMPS,
    ORC_MIXIN_CREDENTIALS_JSON,
    ORC_CREDENTIALS_ALREADY_IN_USE,
    ORC_MIXIN,
    ORC_ONRAMP_NOT_FOUND,
    ORC_INVALID_SRC_ASSET_ID,
    ORC_INVALID_DST_ASSET_ID,
    ORC_INVALID_WITHDRAWAL_ADDRESS,
    ORC_INVALID_MIN_WITHDRAWAL_AMOUNT,
    ORC_INVALID_MIN_SWAP_RATE,
  ];

  static final $core.Map<$core.int, OnrampResultCode> _byValue = $pb.ProtobufEnum.initByValue(values);
  static OnrampResultCode? valueOf($core.int value) => _byValue[value];

  const OnrampResultCode._($core.int v, $core.String n) : super(v, n);
}

class OnrampState extends $pb.ProtobufEnum {
  static const OnrampState OS_INVALID = OnrampState._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'OS_INVALID');
  static const OnrampState OS_NOT_STARTED = OnrampState._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'OS_NOT_STARTED');
  static const OnrampState OS_POLLING = OnrampState._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'OS_POLLING');
  static const OnrampState OS_WAITING = OnrampState._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'OS_WAITING');
  static const OnrampState OS_INTERMITTENT_ERROR = OnrampState._(4, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'OS_INTERMITTENT_ERROR');
  static const OnrampState OS_BLOCKED_ON_SWAP = OnrampState._(5, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'OS_BLOCKED_ON_SWAP');
  static const OnrampState OS_BLOCKED_ON_WITHDRAWAL = OnrampState._(6, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'OS_BLOCKED_ON_WITHDRAWAL');

  static const $core.List<OnrampState> values = <OnrampState> [
    OS_INVALID,
    OS_NOT_STARTED,
    OS_POLLING,
    OS_WAITING,
    OS_INTERMITTENT_ERROR,
    OS_BLOCKED_ON_SWAP,
    OS_BLOCKED_ON_WITHDRAWAL,
  ];

  static final $core.Map<$core.int, OnrampState> _byValue = $pb.ProtobufEnum.initByValue(values);
  static OnrampState? valueOf($core.int value) => _byValue[value];

  const OnrampState._($core.int v, $core.String n) : super(v, n);
}

