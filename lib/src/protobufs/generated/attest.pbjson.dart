///
//  Generated code. Do not modify.
//  source: attest.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use authMessageDescriptor instead')
const AuthMessage$json = const {
  '1': 'AuthMessage',
  '2': const [
    const {'1': 'data', '3': 1, '4': 1, '5': 12, '10': 'data'},
  ],
};

/// Descriptor for `AuthMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List authMessageDescriptor = $convert.base64Decode('CgtBdXRoTWVzc2FnZRISCgRkYXRhGAEgASgMUgRkYXRh');
@$core.Deprecated('Use messageDescriptor instead')
const Message$json = const {
  '1': 'Message',
  '2': const [
    const {'1': 'aad', '3': 1, '4': 1, '5': 12, '10': 'aad'},
    const {'1': 'channel_id', '3': 2, '4': 1, '5': 12, '10': 'channelId'},
    const {'1': 'data', '3': 3, '4': 1, '5': 12, '10': 'data'},
  ],
};

/// Descriptor for `Message`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List messageDescriptor = $convert.base64Decode('CgdNZXNzYWdlEhAKA2FhZBgBIAEoDFIDYWFkEh0KCmNoYW5uZWxfaWQYAiABKAxSCWNoYW5uZWxJZBISCgRkYXRhGAMgASgMUgRkYXRh');
