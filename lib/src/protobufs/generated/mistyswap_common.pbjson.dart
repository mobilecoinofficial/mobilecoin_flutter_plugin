///
//  Generated code. Do not modify.
//  source: mistyswap_common.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use ongoingSwapDescriptor instead')
const OngoingSwap$json = const {
  '1': 'OngoingSwap',
  '2': const [
    const {'1': 'trace_id', '3': 1, '4': 1, '5': 9, '10': 'traceId'},
    const {'1': 'follow_id', '3': 2, '4': 1, '5': 9, '10': 'followId'},
    const {'1': 'src_asset_id', '3': 3, '4': 1, '5': 9, '10': 'srcAssetId'},
    const {'1': 'src_amount', '3': 4, '4': 1, '5': 9, '10': 'srcAmount'},
    const {'1': 'dst_asset_id', '3': 5, '4': 1, '5': 9, '10': 'dstAssetId'},
    const {'1': 'dst_amount_min', '3': 6, '4': 1, '5': 9, '10': 'dstAmountMin'},
    const {'1': 'route_hash_ids', '3': 7, '4': 1, '5': 9, '10': 'routeHashIds'},
    const {'1': 'transfer_json', '3': 8, '4': 1, '5': 9, '10': 'transferJson'},
    const {'1': 'pre_swap_src_balance', '3': 9, '4': 1, '5': 9, '10': 'preSwapSrcBalance'},
    const {'1': 'pre_swap_dst_balance', '3': 10, '4': 1, '5': 9, '10': 'preSwapDstBalance'},
  ],
};

/// Descriptor for `OngoingSwap`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List ongoingSwapDescriptor = $convert.base64Decode('CgtPbmdvaW5nU3dhcBIZCgh0cmFjZV9pZBgBIAEoCVIHdHJhY2VJZBIbCglmb2xsb3dfaWQYAiABKAlSCGZvbGxvd0lkEiAKDHNyY19hc3NldF9pZBgDIAEoCVIKc3JjQXNzZXRJZBIdCgpzcmNfYW1vdW50GAQgASgJUglzcmNBbW91bnQSIAoMZHN0X2Fzc2V0X2lkGAUgASgJUgpkc3RBc3NldElkEiQKDmRzdF9hbW91bnRfbWluGAYgASgJUgxkc3RBbW91bnRNaW4SJAoOcm91dGVfaGFzaF9pZHMYByABKAlSDHJvdXRlSGFzaElkcxIjCg10cmFuc2Zlcl9qc29uGAggASgJUgx0cmFuc2Zlckpzb24SLwoUcHJlX3N3YXBfc3JjX2JhbGFuY2UYCSABKAlSEXByZVN3YXBTcmNCYWxhbmNlEi8KFHByZV9zd2FwX2RzdF9iYWxhbmNlGAogASgJUhFwcmVTd2FwRHN0QmFsYW5jZQ==');
@$core.Deprecated('Use getInfoResponseDescriptor instead')
const GetInfoResponse$json = const {
  '1': 'GetInfoResponse',
  '2': const [
    const {'1': 'max_concurrent_offramps', '3': 1, '4': 1, '5': 4, '10': 'maxConcurrentOfframps'},
    const {'1': 'max_concurrent_onramps', '3': 2, '4': 1, '5': 4, '10': 'maxConcurrentOnramps'},
    const {'1': 'current_offramps', '3': 3, '4': 1, '5': 4, '10': 'currentOfframps'},
    const {'1': 'current_onramps', '3': 4, '4': 1, '5': 4, '10': 'currentOnramps'},
    const {'1': 'offramp_allowed_src_asset_ids', '3': 5, '4': 3, '5': 9, '10': 'offrampAllowedSrcAssetIds'},
    const {'1': 'offramp_allowed_dst_asset_ids', '3': 6, '4': 3, '5': 9, '10': 'offrampAllowedDstAssetIds'},
    const {'1': 'onramp_allowed_src_asset_ids', '3': 7, '4': 3, '5': 9, '10': 'onrampAllowedSrcAssetIds'},
    const {'1': 'onramp_allowed_dst_asset_ids', '3': 8, '4': 3, '5': 9, '10': 'onrampAllowedDstAssetIds'},
  ],
};

/// Descriptor for `GetInfoResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInfoResponseDescriptor = $convert.base64Decode('Cg9HZXRJbmZvUmVzcG9uc2USNgoXbWF4X2NvbmN1cnJlbnRfb2ZmcmFtcHMYASABKARSFW1heENvbmN1cnJlbnRPZmZyYW1wcxI0ChZtYXhfY29uY3VycmVudF9vbnJhbXBzGAIgASgEUhRtYXhDb25jdXJyZW50T25yYW1wcxIpChBjdXJyZW50X29mZnJhbXBzGAMgASgEUg9jdXJyZW50T2ZmcmFtcHMSJwoPY3VycmVudF9vbnJhbXBzGAQgASgEUg5jdXJyZW50T25yYW1wcxJACh1vZmZyYW1wX2FsbG93ZWRfc3JjX2Fzc2V0X2lkcxgFIAMoCVIZb2ZmcmFtcEFsbG93ZWRTcmNBc3NldElkcxJACh1vZmZyYW1wX2FsbG93ZWRfZHN0X2Fzc2V0X2lkcxgGIAMoCVIZb2ZmcmFtcEFsbG93ZWREc3RBc3NldElkcxI+ChxvbnJhbXBfYWxsb3dlZF9zcmNfYXNzZXRfaWRzGAcgAygJUhhvbnJhbXBBbGxvd2VkU3JjQXNzZXRJZHMSPgocb25yYW1wX2FsbG93ZWRfZHN0X2Fzc2V0X2lkcxgIIAMoCVIYb25yYW1wQWxsb3dlZERzdEFzc2V0SWRz');
