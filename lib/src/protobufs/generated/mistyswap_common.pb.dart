///
//  Generated code. Do not modify.
//  source: mistyswap_common.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

class OngoingSwap extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'OngoingSwap', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mistyswap_common'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'traceId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'followId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'srcAssetId')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'srcAmount')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'dstAssetId')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'dstAmountMin')
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'routeHashIds')
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transferJson')
    ..aOS(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'preSwapSrcBalance')
    ..aOS(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'preSwapDstBalance')
    ..hasRequiredFields = false
  ;

  OngoingSwap._() : super();
  factory OngoingSwap({
    $core.String? traceId,
    $core.String? followId,
    $core.String? srcAssetId,
    $core.String? srcAmount,
    $core.String? dstAssetId,
    $core.String? dstAmountMin,
    $core.String? routeHashIds,
    $core.String? transferJson,
    $core.String? preSwapSrcBalance,
    $core.String? preSwapDstBalance,
  }) {
    final _result = create();
    if (traceId != null) {
      _result.traceId = traceId;
    }
    if (followId != null) {
      _result.followId = followId;
    }
    if (srcAssetId != null) {
      _result.srcAssetId = srcAssetId;
    }
    if (srcAmount != null) {
      _result.srcAmount = srcAmount;
    }
    if (dstAssetId != null) {
      _result.dstAssetId = dstAssetId;
    }
    if (dstAmountMin != null) {
      _result.dstAmountMin = dstAmountMin;
    }
    if (routeHashIds != null) {
      _result.routeHashIds = routeHashIds;
    }
    if (transferJson != null) {
      _result.transferJson = transferJson;
    }
    if (preSwapSrcBalance != null) {
      _result.preSwapSrcBalance = preSwapSrcBalance;
    }
    if (preSwapDstBalance != null) {
      _result.preSwapDstBalance = preSwapDstBalance;
    }
    return _result;
  }
  factory OngoingSwap.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory OngoingSwap.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  OngoingSwap clone() => OngoingSwap()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  OngoingSwap copyWith(void Function(OngoingSwap) updates) => super.copyWith((message) => updates(message as OngoingSwap)) as OngoingSwap; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static OngoingSwap create() => OngoingSwap._();
  OngoingSwap createEmptyInstance() => create();
  static $pb.PbList<OngoingSwap> createRepeated() => $pb.PbList<OngoingSwap>();
  @$core.pragma('dart2js:noInline')
  static OngoingSwap getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<OngoingSwap>(create);
  static OngoingSwap? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get traceId => $_getSZ(0);
  @$pb.TagNumber(1)
  set traceId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTraceId() => $_has(0);
  @$pb.TagNumber(1)
  void clearTraceId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get followId => $_getSZ(1);
  @$pb.TagNumber(2)
  set followId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasFollowId() => $_has(1);
  @$pb.TagNumber(2)
  void clearFollowId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get srcAssetId => $_getSZ(2);
  @$pb.TagNumber(3)
  set srcAssetId($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasSrcAssetId() => $_has(2);
  @$pb.TagNumber(3)
  void clearSrcAssetId() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get srcAmount => $_getSZ(3);
  @$pb.TagNumber(4)
  set srcAmount($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasSrcAmount() => $_has(3);
  @$pb.TagNumber(4)
  void clearSrcAmount() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get dstAssetId => $_getSZ(4);
  @$pb.TagNumber(5)
  set dstAssetId($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasDstAssetId() => $_has(4);
  @$pb.TagNumber(5)
  void clearDstAssetId() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get dstAmountMin => $_getSZ(5);
  @$pb.TagNumber(6)
  set dstAmountMin($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasDstAmountMin() => $_has(5);
  @$pb.TagNumber(6)
  void clearDstAmountMin() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get routeHashIds => $_getSZ(6);
  @$pb.TagNumber(7)
  set routeHashIds($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasRouteHashIds() => $_has(6);
  @$pb.TagNumber(7)
  void clearRouteHashIds() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get transferJson => $_getSZ(7);
  @$pb.TagNumber(8)
  set transferJson($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasTransferJson() => $_has(7);
  @$pb.TagNumber(8)
  void clearTransferJson() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get preSwapSrcBalance => $_getSZ(8);
  @$pb.TagNumber(9)
  set preSwapSrcBalance($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasPreSwapSrcBalance() => $_has(8);
  @$pb.TagNumber(9)
  void clearPreSwapSrcBalance() => clearField(9);

  @$pb.TagNumber(10)
  $core.String get preSwapDstBalance => $_getSZ(9);
  @$pb.TagNumber(10)
  set preSwapDstBalance($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasPreSwapDstBalance() => $_has(9);
  @$pb.TagNumber(10)
  void clearPreSwapDstBalance() => clearField(10);
}

class GetInfoResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetInfoResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mistyswap_common'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'maxConcurrentOfframps', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'maxConcurrentOnramps', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currentOfframps', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currentOnramps', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..pPS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'offrampAllowedSrcAssetIds')
    ..pPS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'offrampAllowedDstAssetIds')
    ..pPS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'onrampAllowedSrcAssetIds')
    ..pPS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'onrampAllowedDstAssetIds')
    ..hasRequiredFields = false
  ;

  GetInfoResponse._() : super();
  factory GetInfoResponse({
    $fixnum.Int64? maxConcurrentOfframps,
    $fixnum.Int64? maxConcurrentOnramps,
    $fixnum.Int64? currentOfframps,
    $fixnum.Int64? currentOnramps,
    $core.Iterable<$core.String>? offrampAllowedSrcAssetIds,
    $core.Iterable<$core.String>? offrampAllowedDstAssetIds,
    $core.Iterable<$core.String>? onrampAllowedSrcAssetIds,
    $core.Iterable<$core.String>? onrampAllowedDstAssetIds,
  }) {
    final _result = create();
    if (maxConcurrentOfframps != null) {
      _result.maxConcurrentOfframps = maxConcurrentOfframps;
    }
    if (maxConcurrentOnramps != null) {
      _result.maxConcurrentOnramps = maxConcurrentOnramps;
    }
    if (currentOfframps != null) {
      _result.currentOfframps = currentOfframps;
    }
    if (currentOnramps != null) {
      _result.currentOnramps = currentOnramps;
    }
    if (offrampAllowedSrcAssetIds != null) {
      _result.offrampAllowedSrcAssetIds.addAll(offrampAllowedSrcAssetIds);
    }
    if (offrampAllowedDstAssetIds != null) {
      _result.offrampAllowedDstAssetIds.addAll(offrampAllowedDstAssetIds);
    }
    if (onrampAllowedSrcAssetIds != null) {
      _result.onrampAllowedSrcAssetIds.addAll(onrampAllowedSrcAssetIds);
    }
    if (onrampAllowedDstAssetIds != null) {
      _result.onrampAllowedDstAssetIds.addAll(onrampAllowedDstAssetIds);
    }
    return _result;
  }
  factory GetInfoResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetInfoResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetInfoResponse clone() => GetInfoResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetInfoResponse copyWith(void Function(GetInfoResponse) updates) => super.copyWith((message) => updates(message as GetInfoResponse)) as GetInfoResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetInfoResponse create() => GetInfoResponse._();
  GetInfoResponse createEmptyInstance() => create();
  static $pb.PbList<GetInfoResponse> createRepeated() => $pb.PbList<GetInfoResponse>();
  @$core.pragma('dart2js:noInline')
  static GetInfoResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetInfoResponse>(create);
  static GetInfoResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get maxConcurrentOfframps => $_getI64(0);
  @$pb.TagNumber(1)
  set maxConcurrentOfframps($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasMaxConcurrentOfframps() => $_has(0);
  @$pb.TagNumber(1)
  void clearMaxConcurrentOfframps() => clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get maxConcurrentOnramps => $_getI64(1);
  @$pb.TagNumber(2)
  set maxConcurrentOnramps($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMaxConcurrentOnramps() => $_has(1);
  @$pb.TagNumber(2)
  void clearMaxConcurrentOnramps() => clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get currentOfframps => $_getI64(2);
  @$pb.TagNumber(3)
  set currentOfframps($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasCurrentOfframps() => $_has(2);
  @$pb.TagNumber(3)
  void clearCurrentOfframps() => clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get currentOnramps => $_getI64(3);
  @$pb.TagNumber(4)
  set currentOnramps($fixnum.Int64 v) { $_setInt64(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasCurrentOnramps() => $_has(3);
  @$pb.TagNumber(4)
  void clearCurrentOnramps() => clearField(4);

  @$pb.TagNumber(5)
  $core.List<$core.String> get offrampAllowedSrcAssetIds => $_getList(4);

  @$pb.TagNumber(6)
  $core.List<$core.String> get offrampAllowedDstAssetIds => $_getList(5);

  @$pb.TagNumber(7)
  $core.List<$core.String> get onrampAllowedSrcAssetIds => $_getList(6);

  @$pb.TagNumber(8)
  $core.List<$core.String> get onrampAllowedDstAssetIds => $_getList(7);
}

