///
//  Generated code. Do not modify.
//  source: attest.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'attest.pb.dart' as $0;
export 'attest.pb.dart';

class AttestedApiClient extends $grpc.Client {
  static final _$auth = $grpc.ClientMethod<$0.AuthMessage, $0.AuthMessage>(
      '/attest.AttestedApi/Auth',
      ($0.AuthMessage value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.AuthMessage.fromBuffer(value));

  AttestedApiClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$0.AuthMessage> auth($0.AuthMessage request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$auth, request, options: options);
  }
}

abstract class AttestedApiServiceBase extends $grpc.Service {
  $core.String get $name => 'attest.AttestedApi';

  AttestedApiServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.AuthMessage, $0.AuthMessage>(
        'Auth',
        auth_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.AuthMessage.fromBuffer(value),
        ($0.AuthMessage value) => value.writeToBuffer()));
  }

  $async.Future<$0.AuthMessage> auth_Pre(
      $grpc.ServiceCall call, $async.Future<$0.AuthMessage> request) async {
    return auth(call, await request);
  }

  $async.Future<$0.AuthMessage> auth(
      $grpc.ServiceCall call, $0.AuthMessage request);
}
