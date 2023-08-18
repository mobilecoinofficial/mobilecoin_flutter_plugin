///
//  Generated code. Do not modify.
//  source: mistyswap_onramp.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'attest.pb.dart' as $0;
export 'mistyswap_onramp.pb.dart';

class MistyswapOnrampApiClient extends $grpc.Client {
  static final _$setupOnramp = $grpc.ClientMethod<$0.Message, $0.Message>(
      '/mistyswap_onramp.MistyswapOnrampApi/SetupOnramp',
      ($0.Message value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Message.fromBuffer(value));
  static final _$forgetOnramp = $grpc.ClientMethod<$0.Message, $0.Message>(
      '/mistyswap_onramp.MistyswapOnrampApi/ForgetOnramp',
      ($0.Message value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Message.fromBuffer(value));
  static final _$getOnrampStatus = $grpc.ClientMethod<$0.Message, $0.Message>(
      '/mistyswap_onramp.MistyswapOnrampApi/GetOnrampStatus',
      ($0.Message value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Message.fromBuffer(value));
  static final _$getOnrampDebugInfo =
      $grpc.ClientMethod<$0.Message, $0.Message>(
          '/mistyswap_onramp.MistyswapOnrampApi/GetOnrampDebugInfo',
          ($0.Message value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.Message.fromBuffer(value));

  MistyswapOnrampApiClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$0.Message> setupOnramp($0.Message request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$setupOnramp, request, options: options);
  }

  $grpc.ResponseFuture<$0.Message> forgetOnramp($0.Message request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$forgetOnramp, request, options: options);
  }

  $grpc.ResponseFuture<$0.Message> getOnrampStatus($0.Message request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getOnrampStatus, request, options: options);
  }

  $grpc.ResponseFuture<$0.Message> getOnrampDebugInfo($0.Message request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getOnrampDebugInfo, request, options: options);
  }
}

abstract class MistyswapOnrampApiServiceBase extends $grpc.Service {
  $core.String get $name => 'mistyswap_onramp.MistyswapOnrampApi';

  MistyswapOnrampApiServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.Message, $0.Message>(
        'SetupOnramp',
        setupOnramp_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Message.fromBuffer(value),
        ($0.Message value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.Message, $0.Message>(
        'ForgetOnramp',
        forgetOnramp_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Message.fromBuffer(value),
        ($0.Message value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.Message, $0.Message>(
        'GetOnrampStatus',
        getOnrampStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Message.fromBuffer(value),
        ($0.Message value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.Message, $0.Message>(
        'GetOnrampDebugInfo',
        getOnrampDebugInfo_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Message.fromBuffer(value),
        ($0.Message value) => value.writeToBuffer()));
  }

  $async.Future<$0.Message> setupOnramp_Pre(
      $grpc.ServiceCall call, $async.Future<$0.Message> request) async {
    return setupOnramp(call, await request);
  }

  $async.Future<$0.Message> forgetOnramp_Pre(
      $grpc.ServiceCall call, $async.Future<$0.Message> request) async {
    return forgetOnramp(call, await request);
  }

  $async.Future<$0.Message> getOnrampStatus_Pre(
      $grpc.ServiceCall call, $async.Future<$0.Message> request) async {
    return getOnrampStatus(call, await request);
  }

  $async.Future<$0.Message> getOnrampDebugInfo_Pre(
      $grpc.ServiceCall call, $async.Future<$0.Message> request) async {
    return getOnrampDebugInfo(call, await request);
  }

  $async.Future<$0.Message> setupOnramp(
      $grpc.ServiceCall call, $0.Message request);
  $async.Future<$0.Message> forgetOnramp(
      $grpc.ServiceCall call, $0.Message request);
  $async.Future<$0.Message> getOnrampStatus(
      $grpc.ServiceCall call, $0.Message request);
  $async.Future<$0.Message> getOnrampDebugInfo(
      $grpc.ServiceCall call, $0.Message request);
}
