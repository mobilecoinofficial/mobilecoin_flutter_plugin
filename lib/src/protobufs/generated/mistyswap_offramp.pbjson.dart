///
//  Generated code. Do not modify.
//  source: mistyswap_offramp.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use offrampResultCodeDescriptor instead')
const OfframpResultCode$json = const {
  '1': 'OfframpResultCode',
  '2': const [
    const {'1': 'ORC_INVALID', '2': 0},
    const {'1': 'ORC_OK', '2': 1},
    const {'1': 'ORC_TOO_MANY_OFFRAMPS', '2': 2},
    const {'1': 'ORC_MIXIN_CREDENTIALS_JSON', '2': 3},
    const {'1': 'ORC_OFFRAMP_ALREADY_IN_PROGRESS', '2': 4},
    const {'1': 'ORC_MIXIN', '2': 5},
    const {'1': 'ORC_INVALID_SRC_ASSET_ID', '2': 6},
    const {'1': 'ORC_INVALID_DST_ASSET_ID', '2': 7},
    const {'1': 'ORC_OFFRAMP_ID_NOT_FOUND', '2': 8},
    const {'1': 'ORC_INVALID_SRC_EXPECTED_AMOUNT', '2': 9},
    const {'1': 'ORC_INVALID_MIN_DST_RECEIVED_AMOUNT', '2': 10},
    const {'1': 'ORC_INVALID_MAX_FEE_AMOUNT_IN_DST_TOKENS', '2': 11},
    const {'1': 'ORC_INVALID_FEE_TOKEN_SWAP_MULTIPLIER', '2': 12},
  ],
};

/// Descriptor for `OfframpResultCode`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List offrampResultCodeDescriptor = $convert.base64Decode('ChFPZmZyYW1wUmVzdWx0Q29kZRIPCgtPUkNfSU5WQUxJRBAAEgoKBk9SQ19PSxABEhkKFU9SQ19UT09fTUFOWV9PRkZSQU1QUxACEh4KGk9SQ19NSVhJTl9DUkVERU5USUFMU19KU09OEAMSIwofT1JDX09GRlJBTVBfQUxSRUFEWV9JTl9QUk9HUkVTUxAEEg0KCU9SQ19NSVhJThAFEhwKGE9SQ19JTlZBTElEX1NSQ19BU1NFVF9JRBAGEhwKGE9SQ19JTlZBTElEX0RTVF9BU1NFVF9JRBAHEhwKGE9SQ19PRkZSQU1QX0lEX05PVF9GT1VORBAIEiMKH09SQ19JTlZBTElEX1NSQ19FWFBFQ1RFRF9BTU9VTlQQCRInCiNPUkNfSU5WQUxJRF9NSU5fRFNUX1JFQ0VJVkVEX0FNT1VOVBAKEiwKKE9SQ19JTlZBTElEX01BWF9GRUVfQU1PVU5UX0lOX0RTVF9UT0tFTlMQCxIpCiVPUkNfSU5WQUxJRF9GRUVfVE9LRU5fU1dBUF9NVUxUSVBMSUVSEAw=');
@$core.Deprecated('Use offrampStateDescriptor instead')
const OfframpState$json = const {
  '1': 'OfframpState',
  '2': const [
    const {'1': 'OS_INVALID', '2': 0},
    const {'1': 'OS_NOT_STARTED', '2': 1},
    const {'1': 'OS_POLLING', '2': 2},
    const {'1': 'OS_WAITING', '2': 3},
    const {'1': 'OS_INVALID_WITHDRAWAL_ADDRESS', '2': 4},
    const {'1': 'OS_INTERMITTENT_ERROR', '2': 5},
    const {'1': 'OS_BLOCKED_ON_SWAP', '2': 6},
    const {'1': 'OS_BLOCKED_ON_WITHDRAWAL', '2': 7},
    const {'1': 'OS_WITHDRAWAL_COMPLETED', '2': 8},
    const {'1': 'OS_UNRECOVERABLE_ERROR', '2': 9},
  ],
};

/// Descriptor for `OfframpState`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List offrampStateDescriptor = $convert.base64Decode('CgxPZmZyYW1wU3RhdGUSDgoKT1NfSU5WQUxJRBAAEhIKDk9TX05PVF9TVEFSVEVEEAESDgoKT1NfUE9MTElORxACEg4KCk9TX1dBSVRJTkcQAxIhCh1PU19JTlZBTElEX1dJVEhEUkFXQUxfQUREUkVTUxAEEhkKFU9TX0lOVEVSTUlUVEVOVF9FUlJPUhAFEhYKEk9TX0JMT0NLRURfT05fU1dBUBAGEhwKGE9TX0JMT0NLRURfT05fV0lUSERSQVdBTBAHEhsKF09TX1dJVEhEUkFXQUxfQ09NUExFVEVEEAgSGgoWT1NfVU5SRUNPVkVSQUJMRV9FUlJPUhAJ');
@$core.Deprecated('Use offrampResultDescriptor instead')
const OfframpResult$json = const {
  '1': 'OfframpResult',
  '2': const [
    const {'1': 'code', '3': 1, '4': 1, '5': 14, '6': '.mistyswap_offramp.OfframpResultCode', '10': 'code'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'offramp_id', '3': 3, '4': 1, '5': 12, '10': 'offrampId'},
  ],
};

/// Descriptor for `OfframpResult`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List offrampResultDescriptor = $convert.base64Decode('Cg1PZmZyYW1wUmVzdWx0EjgKBGNvZGUYASABKA4yJC5taXN0eXN3YXBfb2ZmcmFtcC5PZmZyYW1wUmVzdWx0Q29kZVIEY29kZRIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdlEh0KCm9mZnJhbXBfaWQYAyABKAxSCW9mZnJhbXBJZA==');
@$core.Deprecated('Use offrampParamsDescriptor instead')
const OfframpParams$json = const {
  '1': 'OfframpParams',
  '2': const [
    const {'1': 'src_asset_id', '3': 1, '4': 1, '5': 9, '10': 'srcAssetId'},
    const {'1': 'src_expected_amount', '3': 2, '4': 1, '5': 9, '10': 'srcExpectedAmount'},
    const {'1': 'dst_asset_id', '3': 3, '4': 1, '5': 9, '10': 'dstAssetId'},
    const {'1': 'dst_address', '3': 4, '4': 1, '5': 9, '10': 'dstAddress'},
    const {'1': 'dst_address_tag', '3': 5, '4': 1, '5': 9, '10': 'dstAddressTag'},
    const {'1': 'min_dst_received_amount', '3': 6, '4': 1, '5': 9, '10': 'minDstReceivedAmount'},
    const {'1': 'max_fee_amount_in_dst_tokens', '3': 7, '4': 1, '5': 9, '10': 'maxFeeAmountInDstTokens'},
    const {'1': 'fee_token_swap_multiplier', '3': 8, '4': 1, '5': 9, '10': 'feeTokenSwapMultiplier'},
  ],
};

/// Descriptor for `OfframpParams`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List offrampParamsDescriptor = $convert.base64Decode('Cg1PZmZyYW1wUGFyYW1zEiAKDHNyY19hc3NldF9pZBgBIAEoCVIKc3JjQXNzZXRJZBIuChNzcmNfZXhwZWN0ZWRfYW1vdW50GAIgASgJUhFzcmNFeHBlY3RlZEFtb3VudBIgCgxkc3RfYXNzZXRfaWQYAyABKAlSCmRzdEFzc2V0SWQSHwoLZHN0X2FkZHJlc3MYBCABKAlSCmRzdEFkZHJlc3MSJgoPZHN0X2FkZHJlc3NfdGFnGAUgASgJUg1kc3RBZGRyZXNzVGFnEjUKF21pbl9kc3RfcmVjZWl2ZWRfYW1vdW50GAYgASgJUhRtaW5Ec3RSZWNlaXZlZEFtb3VudBI9ChxtYXhfZmVlX2Ftb3VudF9pbl9kc3RfdG9rZW5zGAcgASgJUhdtYXhGZWVBbW91bnRJbkRzdFRva2VucxI5ChlmZWVfdG9rZW5fc3dhcF9tdWx0aXBsaWVyGAggASgJUhZmZWVUb2tlblN3YXBNdWx0aXBsaWVy');
@$core.Deprecated('Use initiateOfframpRequestDescriptor instead')
const InitiateOfframpRequest$json = const {
  '1': 'InitiateOfframpRequest',
  '2': const [
    const {'1': 'mixin_credentials_json', '3': 1, '4': 1, '5': 9, '10': 'mixinCredentialsJson'},
    const {'1': 'params', '3': 2, '4': 1, '5': 11, '6': '.mistyswap_offramp.OfframpParams', '10': 'params'},
  ],
};

/// Descriptor for `InitiateOfframpRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List initiateOfframpRequestDescriptor = $convert.base64Decode('ChZJbml0aWF0ZU9mZnJhbXBSZXF1ZXN0EjQKFm1peGluX2NyZWRlbnRpYWxzX2pzb24YASABKAlSFG1peGluQ3JlZGVudGlhbHNKc29uEjgKBnBhcmFtcxgCIAEoCzIgLm1pc3R5c3dhcF9vZmZyYW1wLk9mZnJhbXBQYXJhbXNSBnBhcmFtcw==');
@$core.Deprecated('Use initiateOfframpResponseDescriptor instead')
const InitiateOfframpResponse$json = const {
  '1': 'InitiateOfframpResponse',
  '2': const [
    const {'1': 'result', '3': 1, '4': 1, '5': 11, '6': '.mistyswap_offramp.OfframpResult', '10': 'result'},
    const {'1': 'offramp_id', '3': 2, '4': 1, '5': 12, '10': 'offrampId'},
  ],
};

/// Descriptor for `InitiateOfframpResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List initiateOfframpResponseDescriptor = $convert.base64Decode('ChdJbml0aWF0ZU9mZnJhbXBSZXNwb25zZRI4CgZyZXN1bHQYASABKAsyIC5taXN0eXN3YXBfb2ZmcmFtcC5PZmZyYW1wUmVzdWx0UgZyZXN1bHQSHQoKb2ZmcmFtcF9pZBgCIAEoDFIJb2ZmcmFtcElk');
@$core.Deprecated('Use forgetOfframpRequestDescriptor instead')
const ForgetOfframpRequest$json = const {
  '1': 'ForgetOfframpRequest',
  '2': const [
    const {'1': 'offramp_id', '3': 1, '4': 1, '5': 12, '10': 'offrampId'},
  ],
};

/// Descriptor for `ForgetOfframpRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List forgetOfframpRequestDescriptor = $convert.base64Decode('ChRGb3JnZXRPZmZyYW1wUmVxdWVzdBIdCgpvZmZyYW1wX2lkGAEgASgMUglvZmZyYW1wSWQ=');
@$core.Deprecated('Use forgetOfframpResponseDescriptor instead')
const ForgetOfframpResponse$json = const {
  '1': 'ForgetOfframpResponse',
  '2': const [
    const {'1': 'result', '3': 1, '4': 1, '5': 11, '6': '.mistyswap_offramp.OfframpResult', '10': 'result'},
  ],
};

/// Descriptor for `ForgetOfframpResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List forgetOfframpResponseDescriptor = $convert.base64Decode('ChVGb3JnZXRPZmZyYW1wUmVzcG9uc2USOAoGcmVzdWx0GAEgASgLMiAubWlzdHlzd2FwX29mZnJhbXAuT2ZmcmFtcFJlc3VsdFIGcmVzdWx0');
@$core.Deprecated('Use offrampDescriptor instead')
const Offramp$json = const {
  '1': 'Offramp',
  '2': const [
    const {'1': 'params', '3': 1, '4': 1, '5': 11, '6': '.mistyswap_offramp.OfframpParams', '10': 'params'},
    const {'1': 'state', '3': 2, '4': 1, '5': 14, '6': '.mistyswap_offramp.OfframpState', '10': 'state'},
    const {'1': 'state_details', '3': 3, '4': 1, '5': 9, '10': 'stateDetails'},
    const {'1': 'mixin_withdrawal_address_json', '3': 4, '4': 1, '5': 9, '10': 'mixinWithdrawalAddressJson'},
    const {'1': 'ongoing_swap', '3': 5, '4': 1, '5': 11, '6': '.mistyswap_common.OngoingSwap', '10': 'ongoingSwap'},
    const {'1': 'ongoing_withdrawal_json', '3': 6, '4': 1, '5': 9, '10': 'ongoingWithdrawalJson'},
    const {'1': 'balances', '3': 7, '4': 3, '5': 11, '6': '.mistyswap_offramp.Offramp.BalancesEntry', '10': 'balances'},
  ],
  '3': const [Offramp_BalancesEntry$json],
};

@$core.Deprecated('Use offrampDescriptor instead')
const Offramp_BalancesEntry$json = const {
  '1': 'BalancesEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    const {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': const {'7': true},
};

/// Descriptor for `Offramp`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List offrampDescriptor = $convert.base64Decode('CgdPZmZyYW1wEjgKBnBhcmFtcxgBIAEoCzIgLm1pc3R5c3dhcF9vZmZyYW1wLk9mZnJhbXBQYXJhbXNSBnBhcmFtcxI1CgVzdGF0ZRgCIAEoDjIfLm1pc3R5c3dhcF9vZmZyYW1wLk9mZnJhbXBTdGF0ZVIFc3RhdGUSIwoNc3RhdGVfZGV0YWlscxgDIAEoCVIMc3RhdGVEZXRhaWxzEkEKHW1peGluX3dpdGhkcmF3YWxfYWRkcmVzc19qc29uGAQgASgJUhptaXhpbldpdGhkcmF3YWxBZGRyZXNzSnNvbhJACgxvbmdvaW5nX3N3YXAYBSABKAsyHS5taXN0eXN3YXBfY29tbW9uLk9uZ29pbmdTd2FwUgtvbmdvaW5nU3dhcBI2ChdvbmdvaW5nX3dpdGhkcmF3YWxfanNvbhgGIAEoCVIVb25nb2luZ1dpdGhkcmF3YWxKc29uEkQKCGJhbGFuY2VzGAcgAygLMigubWlzdHlzd2FwX29mZnJhbXAuT2ZmcmFtcC5CYWxhbmNlc0VudHJ5UghiYWxhbmNlcxo7Cg1CYWxhbmNlc0VudHJ5EhAKA2tleRgBIAEoCVIDa2V5EhQKBXZhbHVlGAIgASgJUgV2YWx1ZToCOAE=');
@$core.Deprecated('Use getOfframpStatusRequestDescriptor instead')
const GetOfframpStatusRequest$json = const {
  '1': 'GetOfframpStatusRequest',
  '2': const [
    const {'1': 'offramp_id', '3': 1, '4': 1, '5': 12, '10': 'offrampId'},
  ],
};

/// Descriptor for `GetOfframpStatusRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getOfframpStatusRequestDescriptor = $convert.base64Decode('ChdHZXRPZmZyYW1wU3RhdHVzUmVxdWVzdBIdCgpvZmZyYW1wX2lkGAEgASgMUglvZmZyYW1wSWQ=');
@$core.Deprecated('Use getOfframpStatusResponseDescriptor instead')
const GetOfframpStatusResponse$json = const {
  '1': 'GetOfframpStatusResponse',
  '2': const [
    const {'1': 'result', '3': 1, '4': 1, '5': 11, '6': '.mistyswap_offramp.OfframpResult', '10': 'result'},
    const {'1': 'offramp', '3': 2, '4': 1, '5': 11, '6': '.mistyswap_offramp.Offramp', '10': 'offramp'},
  ],
};

/// Descriptor for `GetOfframpStatusResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getOfframpStatusResponseDescriptor = $convert.base64Decode('ChhHZXRPZmZyYW1wU3RhdHVzUmVzcG9uc2USOAoGcmVzdWx0GAEgASgLMiAubWlzdHlzd2FwX29mZnJhbXAuT2ZmcmFtcFJlc3VsdFIGcmVzdWx0EjQKB29mZnJhbXAYAiABKAsyGi5taXN0eXN3YXBfb2ZmcmFtcC5PZmZyYW1wUgdvZmZyYW1w');
@$core.Deprecated('Use getOfframpDebugInfoRequestDescriptor instead')
const GetOfframpDebugInfoRequest$json = const {
  '1': 'GetOfframpDebugInfoRequest',
  '2': const [
    const {'1': 'offramp_id', '3': 1, '4': 1, '5': 12, '10': 'offrampId'},
  ],
};

/// Descriptor for `GetOfframpDebugInfoRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getOfframpDebugInfoRequestDescriptor = $convert.base64Decode('ChpHZXRPZmZyYW1wRGVidWdJbmZvUmVxdWVzdBIdCgpvZmZyYW1wX2lkGAEgASgMUglvZmZyYW1wSWQ=');
@$core.Deprecated('Use getOfframpDebugInfoResponseDescriptor instead')
const GetOfframpDebugInfoResponse$json = const {
  '1': 'GetOfframpDebugInfoResponse',
  '2': const [
    const {'1': 'result', '3': 1, '4': 1, '5': 11, '6': '.mistyswap_offramp.OfframpResult', '10': 'result'},
    const {'1': 'debug_info_json', '3': 2, '4': 1, '5': 9, '10': 'debugInfoJson'},
  ],
};

/// Descriptor for `GetOfframpDebugInfoResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getOfframpDebugInfoResponseDescriptor = $convert.base64Decode('ChtHZXRPZmZyYW1wRGVidWdJbmZvUmVzcG9uc2USOAoGcmVzdWx0GAEgASgLMiAubWlzdHlzd2FwX29mZnJhbXAuT2ZmcmFtcFJlc3VsdFIGcmVzdWx0EiYKD2RlYnVnX2luZm9fanNvbhgCIAEoCVINZGVidWdJbmZvSnNvbg==');
