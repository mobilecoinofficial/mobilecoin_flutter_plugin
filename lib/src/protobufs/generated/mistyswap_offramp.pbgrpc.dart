///
//  Generated code. Do not modify.
//  source: mistyswap_offramp.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'attest.pb.dart' as $0;
export 'mistyswap_offramp.pb.dart';

class MistyswapOfframpApiClient extends $grpc.Client {
  static final _$initiateOfframp = $grpc.ClientMethod<$0.Message, $0.Message>(
      '/mistyswap_offramp.MistyswapOfframpApi/InitiateOfframp',
      ($0.Message value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Message.fromBuffer(value));
  static final _$forgetOfframp = $grpc.ClientMethod<$0.Message, $0.Message>(
      '/mistyswap_offramp.MistyswapOfframpApi/ForgetOfframp',
      ($0.Message value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Message.fromBuffer(value));
  static final _$getOfframpStatus = $grpc.ClientMethod<$0.Message, $0.Message>(
      '/mistyswap_offramp.MistyswapOfframpApi/GetOfframpStatus',
      ($0.Message value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Message.fromBuffer(value));
  static final _$getOfframpDebugInfo =
      $grpc.ClientMethod<$0.Message, $0.Message>(
          '/mistyswap_offramp.MistyswapOfframpApi/GetOfframpDebugInfo',
          ($0.Message value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.Message.fromBuffer(value));

  MistyswapOfframpApiClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$0.Message> initiateOfframp($0.Message request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$initiateOfframp, request, options: options);
  }

  $grpc.ResponseFuture<$0.Message> forgetOfframp($0.Message request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$forgetOfframp, request, options: options);
  }

  $grpc.ResponseFuture<$0.Message> getOfframpStatus($0.Message request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getOfframpStatus, request, options: options);
  }

  $grpc.ResponseFuture<$0.Message> getOfframpDebugInfo($0.Message request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getOfframpDebugInfo, request, options: options);
  }
}

abstract class MistyswapOfframpApiServiceBase extends $grpc.Service {
  $core.String get $name => 'mistyswap_offramp.MistyswapOfframpApi';

  MistyswapOfframpApiServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.Message, $0.Message>(
        'InitiateOfframp',
        initiateOfframp_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Message.fromBuffer(value),
        ($0.Message value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.Message, $0.Message>(
        'ForgetOfframp',
        forgetOfframp_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Message.fromBuffer(value),
        ($0.Message value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.Message, $0.Message>(
        'GetOfframpStatus',
        getOfframpStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Message.fromBuffer(value),
        ($0.Message value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.Message, $0.Message>(
        'GetOfframpDebugInfo',
        getOfframpDebugInfo_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Message.fromBuffer(value),
        ($0.Message value) => value.writeToBuffer()));
  }

  $async.Future<$0.Message> initiateOfframp_Pre(
      $grpc.ServiceCall call, $async.Future<$0.Message> request) async {
    return initiateOfframp(call, await request);
  }

  $async.Future<$0.Message> forgetOfframp_Pre(
      $grpc.ServiceCall call, $async.Future<$0.Message> request) async {
    return forgetOfframp(call, await request);
  }

  $async.Future<$0.Message> getOfframpStatus_Pre(
      $grpc.ServiceCall call, $async.Future<$0.Message> request) async {
    return getOfframpStatus(call, await request);
  }

  $async.Future<$0.Message> getOfframpDebugInfo_Pre(
      $grpc.ServiceCall call, $async.Future<$0.Message> request) async {
    return getOfframpDebugInfo(call, await request);
  }

  $async.Future<$0.Message> initiateOfframp(
      $grpc.ServiceCall call, $0.Message request);
  $async.Future<$0.Message> forgetOfframp(
      $grpc.ServiceCall call, $0.Message request);
  $async.Future<$0.Message> getOfframpStatus(
      $grpc.ServiceCall call, $0.Message request);
  $async.Future<$0.Message> getOfframpDebugInfo(
      $grpc.ServiceCall call, $0.Message request);
}
