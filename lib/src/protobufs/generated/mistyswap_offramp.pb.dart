///
//  Generated code. Do not modify.
//  source: mistyswap_offramp.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'mistyswap_common.pb.dart' as $2;

import 'mistyswap_offramp.pbenum.dart';

export 'mistyswap_offramp.pbenum.dart';

class OfframpResult extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'OfframpResult', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mistyswap_offramp'), createEmptyInstance: create)
    ..e<OfframpResultCode>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'code', $pb.PbFieldType.OE, defaultOrMaker: OfframpResultCode.ORC_INVALID, valueOf: OfframpResultCode.valueOf, enumValues: OfframpResultCode.values)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..a<$core.List<$core.int>>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'offrampId', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  OfframpResult._() : super();
  factory OfframpResult({
    OfframpResultCode? code,
    $core.String? message,
    $core.List<$core.int>? offrampId,
  }) {
    final _result = create();
    if (code != null) {
      _result.code = code;
    }
    if (message != null) {
      _result.message = message;
    }
    if (offrampId != null) {
      _result.offrampId = offrampId;
    }
    return _result;
  }
  factory OfframpResult.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory OfframpResult.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  OfframpResult clone() => OfframpResult()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  OfframpResult copyWith(void Function(OfframpResult) updates) => super.copyWith((message) => updates(message as OfframpResult)) as OfframpResult; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static OfframpResult create() => OfframpResult._();
  OfframpResult createEmptyInstance() => create();
  static $pb.PbList<OfframpResult> createRepeated() => $pb.PbList<OfframpResult>();
  @$core.pragma('dart2js:noInline')
  static OfframpResult getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<OfframpResult>(create);
  static OfframpResult? _defaultInstance;

  @$pb.TagNumber(1)
  OfframpResultCode get code => $_getN(0);
  @$pb.TagNumber(1)
  set code(OfframpResultCode v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasCode() => $_has(0);
  @$pb.TagNumber(1)
  void clearCode() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);

  @$pb.TagNumber(3)
  $core.List<$core.int> get offrampId => $_getN(2);
  @$pb.TagNumber(3)
  set offrampId($core.List<$core.int> v) { $_setBytes(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasOfframpId() => $_has(2);
  @$pb.TagNumber(3)
  void clearOfframpId() => clearField(3);
}

class OfframpParams extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'OfframpParams', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mistyswap_offramp'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'srcAssetId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'srcExpectedAmount')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'dstAssetId')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'dstAddress')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'dstAddressTag')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'minDstReceivedAmount')
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'maxFeeAmountInDstTokens')
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'feeTokenSwapMultiplier')
    ..hasRequiredFields = false
  ;

  OfframpParams._() : super();
  factory OfframpParams({
    $core.String? srcAssetId,
    $core.String? srcExpectedAmount,
    $core.String? dstAssetId,
    $core.String? dstAddress,
    $core.String? dstAddressTag,
    $core.String? minDstReceivedAmount,
    $core.String? maxFeeAmountInDstTokens,
    $core.String? feeTokenSwapMultiplier,
  }) {
    final _result = create();
    if (srcAssetId != null) {
      _result.srcAssetId = srcAssetId;
    }
    if (srcExpectedAmount != null) {
      _result.srcExpectedAmount = srcExpectedAmount;
    }
    if (dstAssetId != null) {
      _result.dstAssetId = dstAssetId;
    }
    if (dstAddress != null) {
      _result.dstAddress = dstAddress;
    }
    if (dstAddressTag != null) {
      _result.dstAddressTag = dstAddressTag;
    }
    if (minDstReceivedAmount != null) {
      _result.minDstReceivedAmount = minDstReceivedAmount;
    }
    if (maxFeeAmountInDstTokens != null) {
      _result.maxFeeAmountInDstTokens = maxFeeAmountInDstTokens;
    }
    if (feeTokenSwapMultiplier != null) {
      _result.feeTokenSwapMultiplier = feeTokenSwapMultiplier;
    }
    return _result;
  }
  factory OfframpParams.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory OfframpParams.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  OfframpParams clone() => OfframpParams()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  OfframpParams copyWith(void Function(OfframpParams) updates) => super.copyWith((message) => updates(message as OfframpParams)) as OfframpParams; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static OfframpParams create() => OfframpParams._();
  OfframpParams createEmptyInstance() => create();
  static $pb.PbList<OfframpParams> createRepeated() => $pb.PbList<OfframpParams>();
  @$core.pragma('dart2js:noInline')
  static OfframpParams getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<OfframpParams>(create);
  static OfframpParams? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get srcAssetId => $_getSZ(0);
  @$pb.TagNumber(1)
  set srcAssetId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSrcAssetId() => $_has(0);
  @$pb.TagNumber(1)
  void clearSrcAssetId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get srcExpectedAmount => $_getSZ(1);
  @$pb.TagNumber(2)
  set srcExpectedAmount($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSrcExpectedAmount() => $_has(1);
  @$pb.TagNumber(2)
  void clearSrcExpectedAmount() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get dstAssetId => $_getSZ(2);
  @$pb.TagNumber(3)
  set dstAssetId($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasDstAssetId() => $_has(2);
  @$pb.TagNumber(3)
  void clearDstAssetId() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get dstAddress => $_getSZ(3);
  @$pb.TagNumber(4)
  set dstAddress($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasDstAddress() => $_has(3);
  @$pb.TagNumber(4)
  void clearDstAddress() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get dstAddressTag => $_getSZ(4);
  @$pb.TagNumber(5)
  set dstAddressTag($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasDstAddressTag() => $_has(4);
  @$pb.TagNumber(5)
  void clearDstAddressTag() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get minDstReceivedAmount => $_getSZ(5);
  @$pb.TagNumber(6)
  set minDstReceivedAmount($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasMinDstReceivedAmount() => $_has(5);
  @$pb.TagNumber(6)
  void clearMinDstReceivedAmount() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get maxFeeAmountInDstTokens => $_getSZ(6);
  @$pb.TagNumber(7)
  set maxFeeAmountInDstTokens($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasMaxFeeAmountInDstTokens() => $_has(6);
  @$pb.TagNumber(7)
  void clearMaxFeeAmountInDstTokens() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get feeTokenSwapMultiplier => $_getSZ(7);
  @$pb.TagNumber(8)
  set feeTokenSwapMultiplier($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasFeeTokenSwapMultiplier() => $_has(7);
  @$pb.TagNumber(8)
  void clearFeeTokenSwapMultiplier() => clearField(8);
}

class InitiateOfframpRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'InitiateOfframpRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mistyswap_offramp'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'mixinCredentialsJson')
    ..aOM<OfframpParams>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'params', subBuilder: OfframpParams.create)
    ..hasRequiredFields = false
  ;

  InitiateOfframpRequest._() : super();
  factory InitiateOfframpRequest({
    $core.String? mixinCredentialsJson,
    OfframpParams? params,
  }) {
    final _result = create();
    if (mixinCredentialsJson != null) {
      _result.mixinCredentialsJson = mixinCredentialsJson;
    }
    if (params != null) {
      _result.params = params;
    }
    return _result;
  }
  factory InitiateOfframpRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory InitiateOfframpRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  InitiateOfframpRequest clone() => InitiateOfframpRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  InitiateOfframpRequest copyWith(void Function(InitiateOfframpRequest) updates) => super.copyWith((message) => updates(message as InitiateOfframpRequest)) as InitiateOfframpRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static InitiateOfframpRequest create() => InitiateOfframpRequest._();
  InitiateOfframpRequest createEmptyInstance() => create();
  static $pb.PbList<InitiateOfframpRequest> createRepeated() => $pb.PbList<InitiateOfframpRequest>();
  @$core.pragma('dart2js:noInline')
  static InitiateOfframpRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<InitiateOfframpRequest>(create);
  static InitiateOfframpRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get mixinCredentialsJson => $_getSZ(0);
  @$pb.TagNumber(1)
  set mixinCredentialsJson($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasMixinCredentialsJson() => $_has(0);
  @$pb.TagNumber(1)
  void clearMixinCredentialsJson() => clearField(1);

  @$pb.TagNumber(2)
  OfframpParams get params => $_getN(1);
  @$pb.TagNumber(2)
  set params(OfframpParams v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasParams() => $_has(1);
  @$pb.TagNumber(2)
  void clearParams() => clearField(2);
  @$pb.TagNumber(2)
  OfframpParams ensureParams() => $_ensure(1);
}

class InitiateOfframpResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'InitiateOfframpResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mistyswap_offramp'), createEmptyInstance: create)
    ..aOM<OfframpResult>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'result', subBuilder: OfframpResult.create)
    ..a<$core.List<$core.int>>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'offrampId', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  InitiateOfframpResponse._() : super();
  factory InitiateOfframpResponse({
    OfframpResult? result,
    $core.List<$core.int>? offrampId,
  }) {
    final _result = create();
    if (result != null) {
      _result.result = result;
    }
    if (offrampId != null) {
      _result.offrampId = offrampId;
    }
    return _result;
  }
  factory InitiateOfframpResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory InitiateOfframpResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  InitiateOfframpResponse clone() => InitiateOfframpResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  InitiateOfframpResponse copyWith(void Function(InitiateOfframpResponse) updates) => super.copyWith((message) => updates(message as InitiateOfframpResponse)) as InitiateOfframpResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static InitiateOfframpResponse create() => InitiateOfframpResponse._();
  InitiateOfframpResponse createEmptyInstance() => create();
  static $pb.PbList<InitiateOfframpResponse> createRepeated() => $pb.PbList<InitiateOfframpResponse>();
  @$core.pragma('dart2js:noInline')
  static InitiateOfframpResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<InitiateOfframpResponse>(create);
  static InitiateOfframpResponse? _defaultInstance;

  @$pb.TagNumber(1)
  OfframpResult get result => $_getN(0);
  @$pb.TagNumber(1)
  set result(OfframpResult v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasResult() => $_has(0);
  @$pb.TagNumber(1)
  void clearResult() => clearField(1);
  @$pb.TagNumber(1)
  OfframpResult ensureResult() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.List<$core.int> get offrampId => $_getN(1);
  @$pb.TagNumber(2)
  set offrampId($core.List<$core.int> v) { $_setBytes(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasOfframpId() => $_has(1);
  @$pb.TagNumber(2)
  void clearOfframpId() => clearField(2);
}

class ForgetOfframpRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ForgetOfframpRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mistyswap_offramp'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'offrampId', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  ForgetOfframpRequest._() : super();
  factory ForgetOfframpRequest({
    $core.List<$core.int>? offrampId,
  }) {
    final _result = create();
    if (offrampId != null) {
      _result.offrampId = offrampId;
    }
    return _result;
  }
  factory ForgetOfframpRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ForgetOfframpRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ForgetOfframpRequest clone() => ForgetOfframpRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ForgetOfframpRequest copyWith(void Function(ForgetOfframpRequest) updates) => super.copyWith((message) => updates(message as ForgetOfframpRequest)) as ForgetOfframpRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ForgetOfframpRequest create() => ForgetOfframpRequest._();
  ForgetOfframpRequest createEmptyInstance() => create();
  static $pb.PbList<ForgetOfframpRequest> createRepeated() => $pb.PbList<ForgetOfframpRequest>();
  @$core.pragma('dart2js:noInline')
  static ForgetOfframpRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ForgetOfframpRequest>(create);
  static ForgetOfframpRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get offrampId => $_getN(0);
  @$pb.TagNumber(1)
  set offrampId($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasOfframpId() => $_has(0);
  @$pb.TagNumber(1)
  void clearOfframpId() => clearField(1);
}

class ForgetOfframpResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ForgetOfframpResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mistyswap_offramp'), createEmptyInstance: create)
    ..aOM<OfframpResult>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'result', subBuilder: OfframpResult.create)
    ..hasRequiredFields = false
  ;

  ForgetOfframpResponse._() : super();
  factory ForgetOfframpResponse({
    OfframpResult? result,
  }) {
    final _result = create();
    if (result != null) {
      _result.result = result;
    }
    return _result;
  }
  factory ForgetOfframpResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ForgetOfframpResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ForgetOfframpResponse clone() => ForgetOfframpResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ForgetOfframpResponse copyWith(void Function(ForgetOfframpResponse) updates) => super.copyWith((message) => updates(message as ForgetOfframpResponse)) as ForgetOfframpResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ForgetOfframpResponse create() => ForgetOfframpResponse._();
  ForgetOfframpResponse createEmptyInstance() => create();
  static $pb.PbList<ForgetOfframpResponse> createRepeated() => $pb.PbList<ForgetOfframpResponse>();
  @$core.pragma('dart2js:noInline')
  static ForgetOfframpResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ForgetOfframpResponse>(create);
  static ForgetOfframpResponse? _defaultInstance;

  @$pb.TagNumber(1)
  OfframpResult get result => $_getN(0);
  @$pb.TagNumber(1)
  set result(OfframpResult v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasResult() => $_has(0);
  @$pb.TagNumber(1)
  void clearResult() => clearField(1);
  @$pb.TagNumber(1)
  OfframpResult ensureResult() => $_ensure(0);
}

class Offramp extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Offramp', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mistyswap_offramp'), createEmptyInstance: create)
    ..aOM<OfframpParams>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'params', subBuilder: OfframpParams.create)
    ..e<OfframpState>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'state', $pb.PbFieldType.OE, defaultOrMaker: OfframpState.OS_INVALID, valueOf: OfframpState.valueOf, enumValues: OfframpState.values)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'stateDetails')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'mixinWithdrawalAddressJson')
    ..aOM<$2.OngoingSwap>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'ongoingSwap', subBuilder: $2.OngoingSwap.create)
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'ongoingWithdrawalJson')
    ..m<$core.String, $core.String>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'balances', entryClassName: 'Offramp.BalancesEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('mistyswap_offramp'))
    ..hasRequiredFields = false
  ;

  Offramp._() : super();
  factory Offramp({
    OfframpParams? params,
    OfframpState? state,
    $core.String? stateDetails,
    $core.String? mixinWithdrawalAddressJson,
    $2.OngoingSwap? ongoingSwap,
    $core.String? ongoingWithdrawalJson,
    $core.Map<$core.String, $core.String>? balances,
  }) {
    final _result = create();
    if (params != null) {
      _result.params = params;
    }
    if (state != null) {
      _result.state = state;
    }
    if (stateDetails != null) {
      _result.stateDetails = stateDetails;
    }
    if (mixinWithdrawalAddressJson != null) {
      _result.mixinWithdrawalAddressJson = mixinWithdrawalAddressJson;
    }
    if (ongoingSwap != null) {
      _result.ongoingSwap = ongoingSwap;
    }
    if (ongoingWithdrawalJson != null) {
      _result.ongoingWithdrawalJson = ongoingWithdrawalJson;
    }
    if (balances != null) {
      _result.balances.addAll(balances);
    }
    return _result;
  }
  factory Offramp.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Offramp.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Offramp clone() => Offramp()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Offramp copyWith(void Function(Offramp) updates) => super.copyWith((message) => updates(message as Offramp)) as Offramp; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Offramp create() => Offramp._();
  Offramp createEmptyInstance() => create();
  static $pb.PbList<Offramp> createRepeated() => $pb.PbList<Offramp>();
  @$core.pragma('dart2js:noInline')
  static Offramp getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Offramp>(create);
  static Offramp? _defaultInstance;

  @$pb.TagNumber(1)
  OfframpParams get params => $_getN(0);
  @$pb.TagNumber(1)
  set params(OfframpParams v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasParams() => $_has(0);
  @$pb.TagNumber(1)
  void clearParams() => clearField(1);
  @$pb.TagNumber(1)
  OfframpParams ensureParams() => $_ensure(0);

  @$pb.TagNumber(2)
  OfframpState get state => $_getN(1);
  @$pb.TagNumber(2)
  set state(OfframpState v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasState() => $_has(1);
  @$pb.TagNumber(2)
  void clearState() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get stateDetails => $_getSZ(2);
  @$pb.TagNumber(3)
  set stateDetails($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasStateDetails() => $_has(2);
  @$pb.TagNumber(3)
  void clearStateDetails() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get mixinWithdrawalAddressJson => $_getSZ(3);
  @$pb.TagNumber(4)
  set mixinWithdrawalAddressJson($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasMixinWithdrawalAddressJson() => $_has(3);
  @$pb.TagNumber(4)
  void clearMixinWithdrawalAddressJson() => clearField(4);

  @$pb.TagNumber(5)
  $2.OngoingSwap get ongoingSwap => $_getN(4);
  @$pb.TagNumber(5)
  set ongoingSwap($2.OngoingSwap v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasOngoingSwap() => $_has(4);
  @$pb.TagNumber(5)
  void clearOngoingSwap() => clearField(5);
  @$pb.TagNumber(5)
  $2.OngoingSwap ensureOngoingSwap() => $_ensure(4);

  @$pb.TagNumber(6)
  $core.String get ongoingWithdrawalJson => $_getSZ(5);
  @$pb.TagNumber(6)
  set ongoingWithdrawalJson($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasOngoingWithdrawalJson() => $_has(5);
  @$pb.TagNumber(6)
  void clearOngoingWithdrawalJson() => clearField(6);

  @$pb.TagNumber(7)
  $core.Map<$core.String, $core.String> get balances => $_getMap(6);
}

class GetOfframpStatusRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetOfframpStatusRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mistyswap_offramp'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'offrampId', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  GetOfframpStatusRequest._() : super();
  factory GetOfframpStatusRequest({
    $core.List<$core.int>? offrampId,
  }) {
    final _result = create();
    if (offrampId != null) {
      _result.offrampId = offrampId;
    }
    return _result;
  }
  factory GetOfframpStatusRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetOfframpStatusRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetOfframpStatusRequest clone() => GetOfframpStatusRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetOfframpStatusRequest copyWith(void Function(GetOfframpStatusRequest) updates) => super.copyWith((message) => updates(message as GetOfframpStatusRequest)) as GetOfframpStatusRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetOfframpStatusRequest create() => GetOfframpStatusRequest._();
  GetOfframpStatusRequest createEmptyInstance() => create();
  static $pb.PbList<GetOfframpStatusRequest> createRepeated() => $pb.PbList<GetOfframpStatusRequest>();
  @$core.pragma('dart2js:noInline')
  static GetOfframpStatusRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetOfframpStatusRequest>(create);
  static GetOfframpStatusRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get offrampId => $_getN(0);
  @$pb.TagNumber(1)
  set offrampId($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasOfframpId() => $_has(0);
  @$pb.TagNumber(1)
  void clearOfframpId() => clearField(1);
}

class GetOfframpStatusResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetOfframpStatusResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mistyswap_offramp'), createEmptyInstance: create)
    ..aOM<OfframpResult>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'result', subBuilder: OfframpResult.create)
    ..aOM<Offramp>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'offramp', subBuilder: Offramp.create)
    ..hasRequiredFields = false
  ;

  GetOfframpStatusResponse._() : super();
  factory GetOfframpStatusResponse({
    OfframpResult? result,
    Offramp? offramp,
  }) {
    final _result = create();
    if (result != null) {
      _result.result = result;
    }
    if (offramp != null) {
      _result.offramp = offramp;
    }
    return _result;
  }
  factory GetOfframpStatusResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetOfframpStatusResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetOfframpStatusResponse clone() => GetOfframpStatusResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetOfframpStatusResponse copyWith(void Function(GetOfframpStatusResponse) updates) => super.copyWith((message) => updates(message as GetOfframpStatusResponse)) as GetOfframpStatusResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetOfframpStatusResponse create() => GetOfframpStatusResponse._();
  GetOfframpStatusResponse createEmptyInstance() => create();
  static $pb.PbList<GetOfframpStatusResponse> createRepeated() => $pb.PbList<GetOfframpStatusResponse>();
  @$core.pragma('dart2js:noInline')
  static GetOfframpStatusResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetOfframpStatusResponse>(create);
  static GetOfframpStatusResponse? _defaultInstance;

  @$pb.TagNumber(1)
  OfframpResult get result => $_getN(0);
  @$pb.TagNumber(1)
  set result(OfframpResult v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasResult() => $_has(0);
  @$pb.TagNumber(1)
  void clearResult() => clearField(1);
  @$pb.TagNumber(1)
  OfframpResult ensureResult() => $_ensure(0);

  @$pb.TagNumber(2)
  Offramp get offramp => $_getN(1);
  @$pb.TagNumber(2)
  set offramp(Offramp v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasOfframp() => $_has(1);
  @$pb.TagNumber(2)
  void clearOfframp() => clearField(2);
  @$pb.TagNumber(2)
  Offramp ensureOfframp() => $_ensure(1);
}

class GetOfframpDebugInfoRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetOfframpDebugInfoRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mistyswap_offramp'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'offrampId', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  GetOfframpDebugInfoRequest._() : super();
  factory GetOfframpDebugInfoRequest({
    $core.List<$core.int>? offrampId,
  }) {
    final _result = create();
    if (offrampId != null) {
      _result.offrampId = offrampId;
    }
    return _result;
  }
  factory GetOfframpDebugInfoRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetOfframpDebugInfoRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetOfframpDebugInfoRequest clone() => GetOfframpDebugInfoRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetOfframpDebugInfoRequest copyWith(void Function(GetOfframpDebugInfoRequest) updates) => super.copyWith((message) => updates(message as GetOfframpDebugInfoRequest)) as GetOfframpDebugInfoRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetOfframpDebugInfoRequest create() => GetOfframpDebugInfoRequest._();
  GetOfframpDebugInfoRequest createEmptyInstance() => create();
  static $pb.PbList<GetOfframpDebugInfoRequest> createRepeated() => $pb.PbList<GetOfframpDebugInfoRequest>();
  @$core.pragma('dart2js:noInline')
  static GetOfframpDebugInfoRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetOfframpDebugInfoRequest>(create);
  static GetOfframpDebugInfoRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get offrampId => $_getN(0);
  @$pb.TagNumber(1)
  set offrampId($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasOfframpId() => $_has(0);
  @$pb.TagNumber(1)
  void clearOfframpId() => clearField(1);
}

class GetOfframpDebugInfoResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetOfframpDebugInfoResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mistyswap_offramp'), createEmptyInstance: create)
    ..aOM<OfframpResult>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'result', subBuilder: OfframpResult.create)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'debugInfoJson')
    ..hasRequiredFields = false
  ;

  GetOfframpDebugInfoResponse._() : super();
  factory GetOfframpDebugInfoResponse({
    OfframpResult? result,
    $core.String? debugInfoJson,
  }) {
    final _result = create();
    if (result != null) {
      _result.result = result;
    }
    if (debugInfoJson != null) {
      _result.debugInfoJson = debugInfoJson;
    }
    return _result;
  }
  factory GetOfframpDebugInfoResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetOfframpDebugInfoResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetOfframpDebugInfoResponse clone() => GetOfframpDebugInfoResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetOfframpDebugInfoResponse copyWith(void Function(GetOfframpDebugInfoResponse) updates) => super.copyWith((message) => updates(message as GetOfframpDebugInfoResponse)) as GetOfframpDebugInfoResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetOfframpDebugInfoResponse create() => GetOfframpDebugInfoResponse._();
  GetOfframpDebugInfoResponse createEmptyInstance() => create();
  static $pb.PbList<GetOfframpDebugInfoResponse> createRepeated() => $pb.PbList<GetOfframpDebugInfoResponse>();
  @$core.pragma('dart2js:noInline')
  static GetOfframpDebugInfoResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetOfframpDebugInfoResponse>(create);
  static GetOfframpDebugInfoResponse? _defaultInstance;

  @$pb.TagNumber(1)
  OfframpResult get result => $_getN(0);
  @$pb.TagNumber(1)
  set result(OfframpResult v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasResult() => $_has(0);
  @$pb.TagNumber(1)
  void clearResult() => clearField(1);
  @$pb.TagNumber(1)
  OfframpResult ensureResult() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get debugInfoJson => $_getSZ(1);
  @$pb.TagNumber(2)
  set debugInfoJson($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasDebugInfoJson() => $_has(1);
  @$pb.TagNumber(2)
  void clearDebugInfoJson() => clearField(2);
}

