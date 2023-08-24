///
//  Generated code. Do not modify.
//  source: mistyswap_onramp.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'mistyswap_common.pb.dart' as $2;

import 'mistyswap_onramp.pbenum.dart';

export 'mistyswap_onramp.pbenum.dart';

class OnrampResult extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'OnrampResult', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mistyswap_onramp'), createEmptyInstance: create)
    ..e<OnrampResultCode>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'code', $pb.PbFieldType.OE, defaultOrMaker: OnrampResultCode.ORC_INVALID, valueOf: OnrampResultCode.valueOf, enumValues: OnrampResultCode.values)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..a<$core.List<$core.int>>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'onrampId', $pb.PbFieldType.OY)
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'assetId')
    ..hasRequiredFields = false
  ;

  OnrampResult._() : super();
  factory OnrampResult({
    OnrampResultCode? code,
    $core.String? message,
    $core.List<$core.int>? onrampId,
    $core.String? assetId,
  }) {
    final _result = create();
    if (code != null) {
      _result.code = code;
    }
    if (message != null) {
      _result.message = message;
    }
    if (onrampId != null) {
      _result.onrampId = onrampId;
    }
    if (assetId != null) {
      _result.assetId = assetId;
    }
    return _result;
  }
  factory OnrampResult.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory OnrampResult.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  OnrampResult clone() => OnrampResult()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  OnrampResult copyWith(void Function(OnrampResult) updates) => super.copyWith((message) => updates(message as OnrampResult)) as OnrampResult; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static OnrampResult create() => OnrampResult._();
  OnrampResult createEmptyInstance() => create();
  static $pb.PbList<OnrampResult> createRepeated() => $pb.PbList<OnrampResult>();
  @$core.pragma('dart2js:noInline')
  static OnrampResult getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<OnrampResult>(create);
  static OnrampResult? _defaultInstance;

  @$pb.TagNumber(1)
  OnrampResultCode get code => $_getN(0);
  @$pb.TagNumber(1)
  set code(OnrampResultCode v) { setField(1, v); }
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
  $core.List<$core.int> get onrampId => $_getN(2);
  @$pb.TagNumber(3)
  set onrampId($core.List<$core.int> v) { $_setBytes(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasOnrampId() => $_has(2);
  @$pb.TagNumber(3)
  void clearOnrampId() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get assetId => $_getSZ(3);
  @$pb.TagNumber(4)
  set assetId($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasAssetId() => $_has(3);
  @$pb.TagNumber(4)
  void clearAssetId() => clearField(4);
}

class OnrampParams extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'OnrampParams', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mistyswap_onramp'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'dstAssetId')
    ..m<$core.String, $core.String>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'srcAssetIdToMinSwapRate', entryClassName: 'OnrampParams.SrcAssetIdToMinSwapRateEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('mistyswap_onramp'))
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'dstAddress')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'minWithdrawalAmount')
    ..hasRequiredFields = false
  ;

  OnrampParams._() : super();
  factory OnrampParams({
    $core.String? dstAssetId,
    $core.Map<$core.String, $core.String>? srcAssetIdToMinSwapRate,
    $core.String? dstAddress,
    $core.String? minWithdrawalAmount,
  }) {
    final _result = create();
    if (dstAssetId != null) {
      _result.dstAssetId = dstAssetId;
    }
    if (srcAssetIdToMinSwapRate != null) {
      _result.srcAssetIdToMinSwapRate.addAll(srcAssetIdToMinSwapRate);
    }
    if (dstAddress != null) {
      _result.dstAddress = dstAddress;
    }
    if (minWithdrawalAmount != null) {
      _result.minWithdrawalAmount = minWithdrawalAmount;
    }
    return _result;
  }
  factory OnrampParams.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory OnrampParams.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  OnrampParams clone() => OnrampParams()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  OnrampParams copyWith(void Function(OnrampParams) updates) => super.copyWith((message) => updates(message as OnrampParams)) as OnrampParams; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static OnrampParams create() => OnrampParams._();
  OnrampParams createEmptyInstance() => create();
  static $pb.PbList<OnrampParams> createRepeated() => $pb.PbList<OnrampParams>();
  @$core.pragma('dart2js:noInline')
  static OnrampParams getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<OnrampParams>(create);
  static OnrampParams? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get dstAssetId => $_getSZ(0);
  @$pb.TagNumber(1)
  set dstAssetId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasDstAssetId() => $_has(0);
  @$pb.TagNumber(1)
  void clearDstAssetId() => clearField(1);

  @$pb.TagNumber(2)
  $core.Map<$core.String, $core.String> get srcAssetIdToMinSwapRate => $_getMap(1);

  @$pb.TagNumber(3)
  $core.String get dstAddress => $_getSZ(2);
  @$pb.TagNumber(3)
  set dstAddress($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasDstAddress() => $_has(2);
  @$pb.TagNumber(3)
  void clearDstAddress() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get minWithdrawalAmount => $_getSZ(3);
  @$pb.TagNumber(4)
  set minWithdrawalAmount($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasMinWithdrawalAmount() => $_has(3);
  @$pb.TagNumber(4)
  void clearMinWithdrawalAmount() => clearField(4);
}

class SetupOnrampRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SetupOnrampRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mistyswap_onramp'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'mixinCredentialsJson')
    ..aOM<OnrampParams>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'params', subBuilder: OnrampParams.create)
    ..hasRequiredFields = false
  ;

  SetupOnrampRequest._() : super();
  factory SetupOnrampRequest({
    $core.String? mixinCredentialsJson,
    OnrampParams? params,
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
  factory SetupOnrampRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SetupOnrampRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SetupOnrampRequest clone() => SetupOnrampRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SetupOnrampRequest copyWith(void Function(SetupOnrampRequest) updates) => super.copyWith((message) => updates(message as SetupOnrampRequest)) as SetupOnrampRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SetupOnrampRequest create() => SetupOnrampRequest._();
  SetupOnrampRequest createEmptyInstance() => create();
  static $pb.PbList<SetupOnrampRequest> createRepeated() => $pb.PbList<SetupOnrampRequest>();
  @$core.pragma('dart2js:noInline')
  static SetupOnrampRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SetupOnrampRequest>(create);
  static SetupOnrampRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get mixinCredentialsJson => $_getSZ(0);
  @$pb.TagNumber(1)
  set mixinCredentialsJson($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasMixinCredentialsJson() => $_has(0);
  @$pb.TagNumber(1)
  void clearMixinCredentialsJson() => clearField(1);

  @$pb.TagNumber(2)
  OnrampParams get params => $_getN(1);
  @$pb.TagNumber(2)
  set params(OnrampParams v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasParams() => $_has(1);
  @$pb.TagNumber(2)
  void clearParams() => clearField(2);
  @$pb.TagNumber(2)
  OnrampParams ensureParams() => $_ensure(1);
}

class SetupOnrampResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SetupOnrampResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mistyswap_onramp'), createEmptyInstance: create)
    ..aOM<OnrampResult>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'result', subBuilder: OnrampResult.create)
    ..a<$core.List<$core.int>>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'onrampId', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  SetupOnrampResponse._() : super();
  factory SetupOnrampResponse({
    OnrampResult? result,
    $core.List<$core.int>? onrampId,
  }) {
    final _result = create();
    if (result != null) {
      _result.result = result;
    }
    if (onrampId != null) {
      _result.onrampId = onrampId;
    }
    return _result;
  }
  factory SetupOnrampResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SetupOnrampResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SetupOnrampResponse clone() => SetupOnrampResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SetupOnrampResponse copyWith(void Function(SetupOnrampResponse) updates) => super.copyWith((message) => updates(message as SetupOnrampResponse)) as SetupOnrampResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SetupOnrampResponse create() => SetupOnrampResponse._();
  SetupOnrampResponse createEmptyInstance() => create();
  static $pb.PbList<SetupOnrampResponse> createRepeated() => $pb.PbList<SetupOnrampResponse>();
  @$core.pragma('dart2js:noInline')
  static SetupOnrampResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SetupOnrampResponse>(create);
  static SetupOnrampResponse? _defaultInstance;

  @$pb.TagNumber(1)
  OnrampResult get result => $_getN(0);
  @$pb.TagNumber(1)
  set result(OnrampResult v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasResult() => $_has(0);
  @$pb.TagNumber(1)
  void clearResult() => clearField(1);
  @$pb.TagNumber(1)
  OnrampResult ensureResult() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.List<$core.int> get onrampId => $_getN(1);
  @$pb.TagNumber(2)
  set onrampId($core.List<$core.int> v) { $_setBytes(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasOnrampId() => $_has(1);
  @$pb.TagNumber(2)
  void clearOnrampId() => clearField(2);
}

class ForgetOnrampRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ForgetOnrampRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mistyswap_onramp'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'onrampId', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  ForgetOnrampRequest._() : super();
  factory ForgetOnrampRequest({
    $core.List<$core.int>? onrampId,
  }) {
    final _result = create();
    if (onrampId != null) {
      _result.onrampId = onrampId;
    }
    return _result;
  }
  factory ForgetOnrampRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ForgetOnrampRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ForgetOnrampRequest clone() => ForgetOnrampRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ForgetOnrampRequest copyWith(void Function(ForgetOnrampRequest) updates) => super.copyWith((message) => updates(message as ForgetOnrampRequest)) as ForgetOnrampRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ForgetOnrampRequest create() => ForgetOnrampRequest._();
  ForgetOnrampRequest createEmptyInstance() => create();
  static $pb.PbList<ForgetOnrampRequest> createRepeated() => $pb.PbList<ForgetOnrampRequest>();
  @$core.pragma('dart2js:noInline')
  static ForgetOnrampRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ForgetOnrampRequest>(create);
  static ForgetOnrampRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get onrampId => $_getN(0);
  @$pb.TagNumber(1)
  set onrampId($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasOnrampId() => $_has(0);
  @$pb.TagNumber(1)
  void clearOnrampId() => clearField(1);
}

class ForgetOnrampResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ForgetOnrampResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mistyswap_onramp'), createEmptyInstance: create)
    ..aOM<OnrampResult>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'result', subBuilder: OnrampResult.create)
    ..hasRequiredFields = false
  ;

  ForgetOnrampResponse._() : super();
  factory ForgetOnrampResponse({
    OnrampResult? result,
  }) {
    final _result = create();
    if (result != null) {
      _result.result = result;
    }
    return _result;
  }
  factory ForgetOnrampResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ForgetOnrampResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ForgetOnrampResponse clone() => ForgetOnrampResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ForgetOnrampResponse copyWith(void Function(ForgetOnrampResponse) updates) => super.copyWith((message) => updates(message as ForgetOnrampResponse)) as ForgetOnrampResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ForgetOnrampResponse create() => ForgetOnrampResponse._();
  ForgetOnrampResponse createEmptyInstance() => create();
  static $pb.PbList<ForgetOnrampResponse> createRepeated() => $pb.PbList<ForgetOnrampResponse>();
  @$core.pragma('dart2js:noInline')
  static ForgetOnrampResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ForgetOnrampResponse>(create);
  static ForgetOnrampResponse? _defaultInstance;

  @$pb.TagNumber(1)
  OnrampResult get result => $_getN(0);
  @$pb.TagNumber(1)
  set result(OnrampResult v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasResult() => $_has(0);
  @$pb.TagNumber(1)
  void clearResult() => clearField(1);
  @$pb.TagNumber(1)
  OnrampResult ensureResult() => $_ensure(0);
}

class Onramp extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Onramp', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mistyswap_onramp'), createEmptyInstance: create)
    ..aOM<OnrampParams>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'params', subBuilder: OnrampParams.create)
    ..e<OnrampState>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'state', $pb.PbFieldType.OE, defaultOrMaker: OnrampState.OS_INVALID, valueOf: OnrampState.valueOf, enumValues: OnrampState.values)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'stateDetails')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'mixinWithdrawalAddressJson')
    ..aOM<$2.OngoingSwap>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'ongoingSwap', subBuilder: $2.OngoingSwap.create)
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'ongoingWithdrawalJson')
    ..m<$core.String, $core.String>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'balances', entryClassName: 'Onramp.BalancesEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('mistyswap_onramp'))
    ..hasRequiredFields = false
  ;

  Onramp._() : super();
  factory Onramp({
    OnrampParams? params,
    OnrampState? state,
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
  factory Onramp.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Onramp.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Onramp clone() => Onramp()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Onramp copyWith(void Function(Onramp) updates) => super.copyWith((message) => updates(message as Onramp)) as Onramp; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Onramp create() => Onramp._();
  Onramp createEmptyInstance() => create();
  static $pb.PbList<Onramp> createRepeated() => $pb.PbList<Onramp>();
  @$core.pragma('dart2js:noInline')
  static Onramp getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Onramp>(create);
  static Onramp? _defaultInstance;

  @$pb.TagNumber(1)
  OnrampParams get params => $_getN(0);
  @$pb.TagNumber(1)
  set params(OnrampParams v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasParams() => $_has(0);
  @$pb.TagNumber(1)
  void clearParams() => clearField(1);
  @$pb.TagNumber(1)
  OnrampParams ensureParams() => $_ensure(0);

  @$pb.TagNumber(2)
  OnrampState get state => $_getN(1);
  @$pb.TagNumber(2)
  set state(OnrampState v) { setField(2, v); }
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

class GetOnrampStatusRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetOnrampStatusRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mistyswap_onramp'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'onrampId', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  GetOnrampStatusRequest._() : super();
  factory GetOnrampStatusRequest({
    $core.List<$core.int>? onrampId,
  }) {
    final _result = create();
    if (onrampId != null) {
      _result.onrampId = onrampId;
    }
    return _result;
  }
  factory GetOnrampStatusRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetOnrampStatusRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetOnrampStatusRequest clone() => GetOnrampStatusRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetOnrampStatusRequest copyWith(void Function(GetOnrampStatusRequest) updates) => super.copyWith((message) => updates(message as GetOnrampStatusRequest)) as GetOnrampStatusRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetOnrampStatusRequest create() => GetOnrampStatusRequest._();
  GetOnrampStatusRequest createEmptyInstance() => create();
  static $pb.PbList<GetOnrampStatusRequest> createRepeated() => $pb.PbList<GetOnrampStatusRequest>();
  @$core.pragma('dart2js:noInline')
  static GetOnrampStatusRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetOnrampStatusRequest>(create);
  static GetOnrampStatusRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get onrampId => $_getN(0);
  @$pb.TagNumber(1)
  set onrampId($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasOnrampId() => $_has(0);
  @$pb.TagNumber(1)
  void clearOnrampId() => clearField(1);
}

class GetOnrampStatusResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetOnrampStatusResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mistyswap_onramp'), createEmptyInstance: create)
    ..aOM<OnrampResult>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'result', subBuilder: OnrampResult.create)
    ..aOM<Onramp>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'onramp', subBuilder: Onramp.create)
    ..hasRequiredFields = false
  ;

  GetOnrampStatusResponse._() : super();
  factory GetOnrampStatusResponse({
    OnrampResult? result,
    Onramp? onramp,
  }) {
    final _result = create();
    if (result != null) {
      _result.result = result;
    }
    if (onramp != null) {
      _result.onramp = onramp;
    }
    return _result;
  }
  factory GetOnrampStatusResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetOnrampStatusResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetOnrampStatusResponse clone() => GetOnrampStatusResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetOnrampStatusResponse copyWith(void Function(GetOnrampStatusResponse) updates) => super.copyWith((message) => updates(message as GetOnrampStatusResponse)) as GetOnrampStatusResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetOnrampStatusResponse create() => GetOnrampStatusResponse._();
  GetOnrampStatusResponse createEmptyInstance() => create();
  static $pb.PbList<GetOnrampStatusResponse> createRepeated() => $pb.PbList<GetOnrampStatusResponse>();
  @$core.pragma('dart2js:noInline')
  static GetOnrampStatusResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetOnrampStatusResponse>(create);
  static GetOnrampStatusResponse? _defaultInstance;

  @$pb.TagNumber(1)
  OnrampResult get result => $_getN(0);
  @$pb.TagNumber(1)
  set result(OnrampResult v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasResult() => $_has(0);
  @$pb.TagNumber(1)
  void clearResult() => clearField(1);
  @$pb.TagNumber(1)
  OnrampResult ensureResult() => $_ensure(0);

  @$pb.TagNumber(2)
  Onramp get onramp => $_getN(1);
  @$pb.TagNumber(2)
  set onramp(Onramp v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasOnramp() => $_has(1);
  @$pb.TagNumber(2)
  void clearOnramp() => clearField(2);
  @$pb.TagNumber(2)
  Onramp ensureOnramp() => $_ensure(1);
}

class GetOnrampDebugInfoRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetOnrampDebugInfoRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mistyswap_onramp'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'onrampId', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  GetOnrampDebugInfoRequest._() : super();
  factory GetOnrampDebugInfoRequest({
    $core.List<$core.int>? onrampId,
  }) {
    final _result = create();
    if (onrampId != null) {
      _result.onrampId = onrampId;
    }
    return _result;
  }
  factory GetOnrampDebugInfoRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetOnrampDebugInfoRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetOnrampDebugInfoRequest clone() => GetOnrampDebugInfoRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetOnrampDebugInfoRequest copyWith(void Function(GetOnrampDebugInfoRequest) updates) => super.copyWith((message) => updates(message as GetOnrampDebugInfoRequest)) as GetOnrampDebugInfoRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetOnrampDebugInfoRequest create() => GetOnrampDebugInfoRequest._();
  GetOnrampDebugInfoRequest createEmptyInstance() => create();
  static $pb.PbList<GetOnrampDebugInfoRequest> createRepeated() => $pb.PbList<GetOnrampDebugInfoRequest>();
  @$core.pragma('dart2js:noInline')
  static GetOnrampDebugInfoRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetOnrampDebugInfoRequest>(create);
  static GetOnrampDebugInfoRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get onrampId => $_getN(0);
  @$pb.TagNumber(1)
  set onrampId($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasOnrampId() => $_has(0);
  @$pb.TagNumber(1)
  void clearOnrampId() => clearField(1);
}

class GetOnrampDebugInfoResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetOnrampDebugInfoResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mistyswap_onramp'), createEmptyInstance: create)
    ..aOM<OnrampResult>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'result', subBuilder: OnrampResult.create)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'debugInfoJson')
    ..hasRequiredFields = false
  ;

  GetOnrampDebugInfoResponse._() : super();
  factory GetOnrampDebugInfoResponse({
    OnrampResult? result,
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
  factory GetOnrampDebugInfoResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetOnrampDebugInfoResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetOnrampDebugInfoResponse clone() => GetOnrampDebugInfoResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetOnrampDebugInfoResponse copyWith(void Function(GetOnrampDebugInfoResponse) updates) => super.copyWith((message) => updates(message as GetOnrampDebugInfoResponse)) as GetOnrampDebugInfoResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetOnrampDebugInfoResponse create() => GetOnrampDebugInfoResponse._();
  GetOnrampDebugInfoResponse createEmptyInstance() => create();
  static $pb.PbList<GetOnrampDebugInfoResponse> createRepeated() => $pb.PbList<GetOnrampDebugInfoResponse>();
  @$core.pragma('dart2js:noInline')
  static GetOnrampDebugInfoResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetOnrampDebugInfoResponse>(create);
  static GetOnrampDebugInfoResponse? _defaultInstance;

  @$pb.TagNumber(1)
  OnrampResult get result => $_getN(0);
  @$pb.TagNumber(1)
  set result(OnrampResult v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasResult() => $_has(0);
  @$pb.TagNumber(1)
  void clearResult() => clearField(1);
  @$pb.TagNumber(1)
  OnrampResult ensureResult() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get debugInfoJson => $_getSZ(1);
  @$pb.TagNumber(2)
  set debugInfoJson($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasDebugInfoJson() => $_has(1);
  @$pb.TagNumber(2)
  void clearDebugInfoJson() => clearField(2);
}

