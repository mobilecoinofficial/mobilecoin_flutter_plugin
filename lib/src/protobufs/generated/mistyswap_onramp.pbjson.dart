///
//  Generated code. Do not modify.
//  source: mistyswap_onramp.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use onrampResultCodeDescriptor instead')
const OnrampResultCode$json = const {
  '1': 'OnrampResultCode',
  '2': const [
    const {'1': 'ORC_INVALID', '2': 0},
    const {'1': 'ORC_OK', '2': 1},
    const {'1': 'ORC_TOO_MANY_ONRAMPS', '2': 2},
    const {'1': 'ORC_MIXIN_CREDENTIALS_JSON', '2': 3},
    const {'1': 'ORC_CREDENTIALS_ALREADY_IN_USE', '2': 4},
    const {'1': 'ORC_MIXIN', '2': 5},
    const {'1': 'ORC_ONRAMP_NOT_FOUND', '2': 6},
    const {'1': 'ORC_INVALID_SRC_ASSET_ID', '2': 7},
    const {'1': 'ORC_INVALID_DST_ASSET_ID', '2': 8},
    const {'1': 'ORC_INVALID_WITHDRAWAL_ADDRESS', '2': 9},
    const {'1': 'ORC_INVALID_MIN_WITHDRAWAL_AMOUNT', '2': 10},
    const {'1': 'ORC_INVALID_MIN_SWAP_RATE', '2': 11},
  ],
};

/// Descriptor for `OnrampResultCode`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List onrampResultCodeDescriptor = $convert.base64Decode('ChBPbnJhbXBSZXN1bHRDb2RlEg8KC09SQ19JTlZBTElEEAASCgoGT1JDX09LEAESGAoUT1JDX1RPT19NQU5ZX09OUkFNUFMQAhIeChpPUkNfTUlYSU5fQ1JFREVOVElBTFNfSlNPThADEiIKHk9SQ19DUkVERU5USUFMU19BTFJFQURZX0lOX1VTRRAEEg0KCU9SQ19NSVhJThAFEhgKFE9SQ19PTlJBTVBfTk9UX0ZPVU5EEAYSHAoYT1JDX0lOVkFMSURfU1JDX0FTU0VUX0lEEAcSHAoYT1JDX0lOVkFMSURfRFNUX0FTU0VUX0lEEAgSIgoeT1JDX0lOVkFMSURfV0lUSERSQVdBTF9BRERSRVNTEAkSJQohT1JDX0lOVkFMSURfTUlOX1dJVEhEUkFXQUxfQU1PVU5UEAoSHQoZT1JDX0lOVkFMSURfTUlOX1NXQVBfUkFURRAL');
@$core.Deprecated('Use onrampStateDescriptor instead')
const OnrampState$json = const {
  '1': 'OnrampState',
  '2': const [
    const {'1': 'OS_INVALID', '2': 0},
    const {'1': 'OS_NOT_STARTED', '2': 1},
    const {'1': 'OS_POLLING', '2': 2},
    const {'1': 'OS_WAITING', '2': 3},
    const {'1': 'OS_INTERMITTENT_ERROR', '2': 4},
    const {'1': 'OS_BLOCKED_ON_SWAP', '2': 5},
    const {'1': 'OS_BLOCKED_ON_WITHDRAWAL', '2': 6},
  ],
};

/// Descriptor for `OnrampState`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List onrampStateDescriptor = $convert.base64Decode('CgtPbnJhbXBTdGF0ZRIOCgpPU19JTlZBTElEEAASEgoOT1NfTk9UX1NUQVJURUQQARIOCgpPU19QT0xMSU5HEAISDgoKT1NfV0FJVElORxADEhkKFU9TX0lOVEVSTUlUVEVOVF9FUlJPUhAEEhYKEk9TX0JMT0NLRURfT05fU1dBUBAFEhwKGE9TX0JMT0NLRURfT05fV0lUSERSQVdBTBAG');
@$core.Deprecated('Use onrampResultDescriptor instead')
const OnrampResult$json = const {
  '1': 'OnrampResult',
  '2': const [
    const {'1': 'code', '3': 1, '4': 1, '5': 14, '6': '.mistyswap_onramp.OnrampResultCode', '10': 'code'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'onramp_id', '3': 3, '4': 1, '5': 12, '10': 'onrampId'},
    const {'1': 'asset_id', '3': 4, '4': 1, '5': 9, '10': 'assetId'},
  ],
};

/// Descriptor for `OnrampResult`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List onrampResultDescriptor = $convert.base64Decode('CgxPbnJhbXBSZXN1bHQSNgoEY29kZRgBIAEoDjIiLm1pc3R5c3dhcF9vbnJhbXAuT25yYW1wUmVzdWx0Q29kZVIEY29kZRIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdlEhsKCW9ucmFtcF9pZBgDIAEoDFIIb25yYW1wSWQSGQoIYXNzZXRfaWQYBCABKAlSB2Fzc2V0SWQ=');
@$core.Deprecated('Use onrampParamsDescriptor instead')
const OnrampParams$json = const {
  '1': 'OnrampParams',
  '2': const [
    const {'1': 'dst_asset_id', '3': 1, '4': 1, '5': 9, '10': 'dstAssetId'},
    const {'1': 'src_asset_id_to_min_swap_rate', '3': 2, '4': 3, '5': 11, '6': '.mistyswap_onramp.OnrampParams.SrcAssetIdToMinSwapRateEntry', '10': 'srcAssetIdToMinSwapRate'},
    const {'1': 'dst_address', '3': 3, '4': 1, '5': 9, '10': 'dstAddress'},
    const {'1': 'min_withdrawal_amount', '3': 4, '4': 1, '5': 9, '10': 'minWithdrawalAmount'},
  ],
  '3': const [OnrampParams_SrcAssetIdToMinSwapRateEntry$json],
};

@$core.Deprecated('Use onrampParamsDescriptor instead')
const OnrampParams_SrcAssetIdToMinSwapRateEntry$json = const {
  '1': 'SrcAssetIdToMinSwapRateEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    const {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': const {'7': true},
};

/// Descriptor for `OnrampParams`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List onrampParamsDescriptor = $convert.base64Decode('CgxPbnJhbXBQYXJhbXMSIAoMZHN0X2Fzc2V0X2lkGAEgASgJUgpkc3RBc3NldElkEnsKHXNyY19hc3NldF9pZF90b19taW5fc3dhcF9yYXRlGAIgAygLMjsubWlzdHlzd2FwX29ucmFtcC5PbnJhbXBQYXJhbXMuU3JjQXNzZXRJZFRvTWluU3dhcFJhdGVFbnRyeVIXc3JjQXNzZXRJZFRvTWluU3dhcFJhdGUSHwoLZHN0X2FkZHJlc3MYAyABKAlSCmRzdEFkZHJlc3MSMgoVbWluX3dpdGhkcmF3YWxfYW1vdW50GAQgASgJUhNtaW5XaXRoZHJhd2FsQW1vdW50GkoKHFNyY0Fzc2V0SWRUb01pblN3YXBSYXRlRW50cnkSEAoDa2V5GAEgASgJUgNrZXkSFAoFdmFsdWUYAiABKAlSBXZhbHVlOgI4AQ==');
@$core.Deprecated('Use setupOnrampRequestDescriptor instead')
const SetupOnrampRequest$json = const {
  '1': 'SetupOnrampRequest',
  '2': const [
    const {'1': 'mixin_credentials_json', '3': 1, '4': 1, '5': 9, '10': 'mixinCredentialsJson'},
    const {'1': 'params', '3': 2, '4': 1, '5': 11, '6': '.mistyswap_onramp.OnrampParams', '10': 'params'},
  ],
};

/// Descriptor for `SetupOnrampRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List setupOnrampRequestDescriptor = $convert.base64Decode('ChJTZXR1cE9ucmFtcFJlcXVlc3QSNAoWbWl4aW5fY3JlZGVudGlhbHNfanNvbhgBIAEoCVIUbWl4aW5DcmVkZW50aWFsc0pzb24SNgoGcGFyYW1zGAIgASgLMh4ubWlzdHlzd2FwX29ucmFtcC5PbnJhbXBQYXJhbXNSBnBhcmFtcw==');
@$core.Deprecated('Use setupOnrampResponseDescriptor instead')
const SetupOnrampResponse$json = const {
  '1': 'SetupOnrampResponse',
  '2': const [
    const {'1': 'result', '3': 1, '4': 1, '5': 11, '6': '.mistyswap_onramp.OnrampResult', '10': 'result'},
    const {'1': 'onramp_id', '3': 2, '4': 1, '5': 12, '10': 'onrampId'},
  ],
};

/// Descriptor for `SetupOnrampResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List setupOnrampResponseDescriptor = $convert.base64Decode('ChNTZXR1cE9ucmFtcFJlc3BvbnNlEjYKBnJlc3VsdBgBIAEoCzIeLm1pc3R5c3dhcF9vbnJhbXAuT25yYW1wUmVzdWx0UgZyZXN1bHQSGwoJb25yYW1wX2lkGAIgASgMUghvbnJhbXBJZA==');
@$core.Deprecated('Use forgetOnrampRequestDescriptor instead')
const ForgetOnrampRequest$json = const {
  '1': 'ForgetOnrampRequest',
  '2': const [
    const {'1': 'onramp_id', '3': 1, '4': 1, '5': 12, '10': 'onrampId'},
  ],
};

/// Descriptor for `ForgetOnrampRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List forgetOnrampRequestDescriptor = $convert.base64Decode('ChNGb3JnZXRPbnJhbXBSZXF1ZXN0EhsKCW9ucmFtcF9pZBgBIAEoDFIIb25yYW1wSWQ=');
@$core.Deprecated('Use forgetOnrampResponseDescriptor instead')
const ForgetOnrampResponse$json = const {
  '1': 'ForgetOnrampResponse',
  '2': const [
    const {'1': 'result', '3': 1, '4': 1, '5': 11, '6': '.mistyswap_onramp.OnrampResult', '10': 'result'},
  ],
};

/// Descriptor for `ForgetOnrampResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List forgetOnrampResponseDescriptor = $convert.base64Decode('ChRGb3JnZXRPbnJhbXBSZXNwb25zZRI2CgZyZXN1bHQYASABKAsyHi5taXN0eXN3YXBfb25yYW1wLk9ucmFtcFJlc3VsdFIGcmVzdWx0');
@$core.Deprecated('Use onrampDescriptor instead')
const Onramp$json = const {
  '1': 'Onramp',
  '2': const [
    const {'1': 'params', '3': 1, '4': 1, '5': 11, '6': '.mistyswap_onramp.OnrampParams', '10': 'params'},
    const {'1': 'state', '3': 2, '4': 1, '5': 14, '6': '.mistyswap_onramp.OnrampState', '10': 'state'},
    const {'1': 'state_details', '3': 3, '4': 1, '5': 9, '10': 'stateDetails'},
    const {'1': 'mixin_withdrawal_address_json', '3': 4, '4': 1, '5': 9, '10': 'mixinWithdrawalAddressJson'},
    const {'1': 'ongoing_swap', '3': 5, '4': 1, '5': 11, '6': '.mistyswap_common.OngoingSwap', '10': 'ongoingSwap'},
    const {'1': 'ongoing_withdrawal_json', '3': 6, '4': 1, '5': 9, '10': 'ongoingWithdrawalJson'},
    const {'1': 'balances', '3': 7, '4': 3, '5': 11, '6': '.mistyswap_onramp.Onramp.BalancesEntry', '10': 'balances'},
  ],
  '3': const [Onramp_BalancesEntry$json],
};

@$core.Deprecated('Use onrampDescriptor instead')
const Onramp_BalancesEntry$json = const {
  '1': 'BalancesEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    const {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': const {'7': true},
};

/// Descriptor for `Onramp`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List onrampDescriptor = $convert.base64Decode('CgZPbnJhbXASNgoGcGFyYW1zGAEgASgLMh4ubWlzdHlzd2FwX29ucmFtcC5PbnJhbXBQYXJhbXNSBnBhcmFtcxIzCgVzdGF0ZRgCIAEoDjIdLm1pc3R5c3dhcF9vbnJhbXAuT25yYW1wU3RhdGVSBXN0YXRlEiMKDXN0YXRlX2RldGFpbHMYAyABKAlSDHN0YXRlRGV0YWlscxJBCh1taXhpbl93aXRoZHJhd2FsX2FkZHJlc3NfanNvbhgEIAEoCVIabWl4aW5XaXRoZHJhd2FsQWRkcmVzc0pzb24SQAoMb25nb2luZ19zd2FwGAUgASgLMh0ubWlzdHlzd2FwX2NvbW1vbi5PbmdvaW5nU3dhcFILb25nb2luZ1N3YXASNgoXb25nb2luZ193aXRoZHJhd2FsX2pzb24YBiABKAlSFW9uZ29pbmdXaXRoZHJhd2FsSnNvbhJCCghiYWxhbmNlcxgHIAMoCzImLm1pc3R5c3dhcF9vbnJhbXAuT25yYW1wLkJhbGFuY2VzRW50cnlSCGJhbGFuY2VzGjsKDUJhbGFuY2VzRW50cnkSEAoDa2V5GAEgASgJUgNrZXkSFAoFdmFsdWUYAiABKAlSBXZhbHVlOgI4AQ==');
@$core.Deprecated('Use getOnrampStatusRequestDescriptor instead')
const GetOnrampStatusRequest$json = const {
  '1': 'GetOnrampStatusRequest',
  '2': const [
    const {'1': 'onramp_id', '3': 1, '4': 1, '5': 12, '10': 'onrampId'},
  ],
};

/// Descriptor for `GetOnrampStatusRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getOnrampStatusRequestDescriptor = $convert.base64Decode('ChZHZXRPbnJhbXBTdGF0dXNSZXF1ZXN0EhsKCW9ucmFtcF9pZBgBIAEoDFIIb25yYW1wSWQ=');
@$core.Deprecated('Use getOnrampStatusResponseDescriptor instead')
const GetOnrampStatusResponse$json = const {
  '1': 'GetOnrampStatusResponse',
  '2': const [
    const {'1': 'result', '3': 1, '4': 1, '5': 11, '6': '.mistyswap_onramp.OnrampResult', '10': 'result'},
    const {'1': 'onramp', '3': 2, '4': 1, '5': 11, '6': '.mistyswap_onramp.Onramp', '10': 'onramp'},
  ],
};

/// Descriptor for `GetOnrampStatusResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getOnrampStatusResponseDescriptor = $convert.base64Decode('ChdHZXRPbnJhbXBTdGF0dXNSZXNwb25zZRI2CgZyZXN1bHQYASABKAsyHi5taXN0eXN3YXBfb25yYW1wLk9ucmFtcFJlc3VsdFIGcmVzdWx0EjAKBm9ucmFtcBgCIAEoCzIYLm1pc3R5c3dhcF9vbnJhbXAuT25yYW1wUgZvbnJhbXA=');
@$core.Deprecated('Use getOnrampDebugInfoRequestDescriptor instead')
const GetOnrampDebugInfoRequest$json = const {
  '1': 'GetOnrampDebugInfoRequest',
  '2': const [
    const {'1': 'onramp_id', '3': 1, '4': 1, '5': 12, '10': 'onrampId'},
  ],
};

/// Descriptor for `GetOnrampDebugInfoRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getOnrampDebugInfoRequestDescriptor = $convert.base64Decode('ChlHZXRPbnJhbXBEZWJ1Z0luZm9SZXF1ZXN0EhsKCW9ucmFtcF9pZBgBIAEoDFIIb25yYW1wSWQ=');
@$core.Deprecated('Use getOnrampDebugInfoResponseDescriptor instead')
const GetOnrampDebugInfoResponse$json = const {
  '1': 'GetOnrampDebugInfoResponse',
  '2': const [
    const {'1': 'result', '3': 1, '4': 1, '5': 11, '6': '.mistyswap_onramp.OnrampResult', '10': 'result'},
    const {'1': 'debug_info_json', '3': 2, '4': 1, '5': 9, '10': 'debugInfoJson'},
  ],
};

/// Descriptor for `GetOnrampDebugInfoResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getOnrampDebugInfoResponseDescriptor = $convert.base64Decode('ChpHZXRPbnJhbXBEZWJ1Z0luZm9SZXNwb25zZRI2CgZyZXN1bHQYASABKAsyHi5taXN0eXN3YXBfb25yYW1wLk9ucmFtcFJlc3VsdFIGcmVzdWx0EiYKD2RlYnVnX2luZm9fanNvbhgCIAEoCVINZGVidWdJbmZvSnNvbg==');
