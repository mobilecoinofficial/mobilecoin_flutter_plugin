///
//  Generated code. Do not modify.
//  source: mistyswap_common.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'google/protobuf/empty.pb.dart' as $1;
import 'mistyswap_common.pb.dart' as $2;
export 'mistyswap_common.pb.dart';

class MistyswapCommonApiClient extends $grpc.Client {
  static final _$getInfo = $grpc.ClientMethod<$1.Empty, $2.GetInfoResponse>(
      '/mistyswap_common.MistyswapCommonApi/GetInfo',
      ($1.Empty value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $2.GetInfoResponse.fromBuffer(value));

  MistyswapCommonApiClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$2.GetInfoResponse> getInfo($1.Empty request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInfo, request, options: options);
  }
}

abstract class MistyswapCommonApiServiceBase extends $grpc.Service {
  $core.String get $name => 'mistyswap_common.MistyswapCommonApi';

  MistyswapCommonApiServiceBase() {
    $addMethod($grpc.ServiceMethod<$1.Empty, $2.GetInfoResponse>(
        'GetInfo',
        getInfo_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.Empty.fromBuffer(value),
        ($2.GetInfoResponse value) => value.writeToBuffer()));
  }

  $async.Future<$2.GetInfoResponse> getInfo_Pre(
      $grpc.ServiceCall call, $async.Future<$1.Empty> request) async {
    return getInfo(call, await request);
  }

  $async.Future<$2.GetInfoResponse> getInfo(
      $grpc.ServiceCall call, $1.Empty request);
}
