// Copyright (c) 2021-2024 MobileCoin. All rights reserved.

import 'dart:async';
import 'dart:typed_data';

import 'package:mobilecoin_flutter/src/account_key.dart';
import 'package:mobilecoin_flutter/src/mobilecoin_flutter_plugin_channel_api.dart';
import 'package:mobilecoin_flutter/src/platform_object.dart';
import 'package:mobilecoin_flutter/src/public_address.dart';
import 'package:mobilecoin_flutter/src/protobufs/generated/mistyswap_offramp.pb.dart';

class MobileCoinFlutterClient extends PlatformObject {
  MobileCoinFlutterClient(int objectId) : super(id: objectId);

  static Future<MobileCoinFlutterClient> create(AccountKey accountKey) async {
    final objectId = await MobileCoinFlutterPluginChannelApi.instance
        .createMobileCoinClient(accountKey);

    return MobileCoinFlutterClient(objectId);
  }

  static Future<Uint8List> mnemonicToBip39Entropy(String mnemonicPhrase) =>
      MobileCoinFlutterPluginChannelApi.instance
          .mnemonicToBip39Entropy(mnemonicPhrase);

  static Future<String> mnemonicAllWords() =>
      MobileCoinFlutterPluginChannelApi.instance.mnemonicAllWords();

  static Future<Uint8List> publicAddressGetAddressHash({
    required int publicAddressId,
  }) =>
      MobileCoinFlutterPluginChannelApi.instance
          .publicAddressGetAddressHash(publicAddressId: publicAddressId);

  static Future<int> printableWrapperFromB58String({
    required String b58String,
  }) =>
      MobileCoinFlutterPluginChannelApi.instance
          .printableWrapperFromB58String(b58String: b58String);

  static Future<int> paymentRequestCreate({
    required PublicAddress publicAddress,
    required BigInt tokenId,
    String? memo,
    BigInt? amount,
  }) =>
      MobileCoinFlutterPluginChannelApi.instance.paymentRequestCreate(
        publicAddress: publicAddress,
        tokenId: tokenId,
        memo: memo,
        amount: amount,
      );

  static Future<int> printableWrapperFromPaymentRequest({
    required int paymentRequestId,
  }) =>
      MobileCoinFlutterPluginChannelApi.instance
          .printableWrapperFromPaymentRequest(
        paymentRequestId: paymentRequestId,
      );

  static Future<String> printableWrapperToB58String({
    required int printableWrapperId,
  }) =>
      MobileCoinFlutterPluginChannelApi.instance.printableWrapperToB58String(
        printableWrapperId: printableWrapperId,
      );

  Future<Map<String, Object?>> createPendingTransaction({
    required PublicAddress recipient,
    required BigInt amount,
    required BigInt fee,
    required BigInt tokenId,
    required String rngSeed,
    BigInt? paymentRequestId,
  }) async {
    return await MobileCoinFlutterPluginChannelApi.instance
        .createPendingTransaction(
      mobileClientId: id,
      recipientId: recipient.id,
      fee: fee,
      amount: amount,
      tokenId: tokenId,
      rngSeed: rngSeed,
      paymentRequestId: paymentRequestId,
    );
  }

  Future<String> sendFunds(Uint8List serializedTransaction) async {
    return await MobileCoinFlutterPluginChannelApi.instance.sendFunds(
      mobileClientId: id,
      serializedTransaction: serializedTransaction,
    );
  }

  Future<int> checkTransactionStatus(int receiptId) async {
    final result =
        await MobileCoinFlutterPluginChannelApi.instance.checkTransactionStatus(
      mobileClientId: id,
      receiptId: receiptId,
    );
    return result;
  }

  Future<String> getBalance() async {
    return await MobileCoinFlutterPluginChannelApi.instance
        .getBalance(mobileCoinClientId: id);
  }

  /// Gets activity associated with the current client as a JSON string.
  ///
  /// [serializedKnownPublicAddresses] used for reading RTH memos.
  /// When supplied, it returns hashed public addresses of a transaction's
  /// opposite party, which mitigates strangers looking up addresses that
  /// they don't have the hash of.
  /// The best way to supply it is with [PublicAddress.toByteArray].
  /// Because of the async nature of that call, the consumer will likely
  /// want to cache those serialized addresses.
  ///
  /// [minTxOutBlockIndex] is used to filter out TxOuts that have already been seen.
  /// It refers to either the received block index or the spent block index!
  /// The purpose of this argument is to allow users to not receive TxOuts they have already seen,
  /// and for which nothing has changed.
  Future<String> getAccountActivity(
    List<Uint8List> serializedKnownPublicAddresses,
    BigInt minTxOutBlockIndex,
  ) async {
    return await MobileCoinFlutterPluginChannelApi.instance.getAccountActivity(
      mobileCoinClientId: id,
      serializedKnownPublicAddresses: serializedKnownPublicAddresses,
      minTxOutBlockIndex: minTxOutBlockIndex,
    );
  }

  /// Set the basic HTTP authorization username and password for future requests.
  Future<void> setAuthorization({
    required String username,
    required String password,
  }) async {
    return await MobileCoinFlutterPluginChannelApi.instance.setAuthorization(
      mobileClientId: id,
      username: username,
      password: password,
    );
  }

  /// Returns whether or not MobileCoin client can send a specified amount
  /// without account defragmentation
  Future<bool> requiresDefragmentation(BigInt tokenId, BigInt amount) async {
    return await MobileCoinFlutterPluginChannelApi.instance
        .accountRequiresDefragmentation(
      mobileCoinClientId: id,
      amount: amount,
      tokenId: tokenId,
    );
  }

  /// Defragments the user's account.
  ///
  /// An account needs to be defragmented when an account balance consists
  /// of multiple coins and there are no big enough coins to successfully
  /// send the transaction.
  /// If the account is too fragmented, it might be necessary to defragment
  /// the account more than once. However, wallet fragmentation is a
  /// rare occurrence since there is an internal mechanism to defragment
  /// the account during other operations.
  ///
  /// `shouldWriteRTHMemos` writes sender and destination memos for a defrag
  /// transaction if true.
  Future<void> defragmentAccount({
    required BigInt tokenId,
    required BigInt amount,
    bool? shouldWriteRTHMemos = true,
    String? rngSeed,
  }) async {
    return await MobileCoinFlutterPluginChannelApi.instance.defragmentAccount(
      mobileCoinClientId: id,
      amount: amount,
      tokenId: tokenId,
      shouldWriteRTHMemos: shouldWriteRTHMemos!,
      rngSeed: rngSeed,
    );
  }

  /// Estimates the minimum fee required to send a transaction with the
  /// specified amount. Includes defragmentation fees.
  Future<BigInt> estimateTotalFee({
    required BigInt tokenId,
    required BigInt amount,
  }) async {
    return await MobileCoinFlutterPluginChannelApi.instance.estimateTotalFee(
      mobileCoinClientId: id,
      amount: amount,
      tokenId: tokenId,
    );
  }

  /// Calculate the total transferable amount excluding all the required
  /// fees for such transfer.
  Future<BigInt> getTransferableAmount({required BigInt tokenId}) {
    return MobileCoinFlutterPluginChannelApi.instance
        .getTransferableAmount(mobileCoinClientId: id, tokenId: tokenId);
  }

  Future<Map<String, Object?>> createProofOfReserveSignedContingentInput(
    Uint8List txOutPublicKeyBytes,
  ) {
    return MobileCoinFlutterPluginChannelApi.instance
        .createProofOfReserveSignedContingentInput(
      mobileCoinClientId: id,
      txOutPublicKeyBytes: txOutPublicKeyBytes,
    );
  }

  /// Initiates a Mistyswap offramp request
  ///
  Future<InitiateOfframpResponse> attestedMistySwapClientInitiateOfframp({
    required InitiateOfframpRequest request,
  }) async {
    return await MobileCoinFlutterPluginChannelApi.instance
        .attestedMistySwapClientInitiateOfframp(
      mobileCoinClientId: id,
      initiateOfframpRequest: request,
    );
  }

  /// Gets status for a Mistyswap offramp request
  ///
  Future<GetOfframpStatusResponse> attestedMistySwapClientGetOfframpStatus({
    required GetOfframpStatusRequest request,
  }) async {
    return await MobileCoinFlutterPluginChannelApi.instance
        .attestedMistySwapClientGetOfframpStatus(
      mobileCoinClientId: id,
      getOfframpStatusRequest: request,
    );
  }

  /// Forgets a Mistyswap offramp request
  ///
  Future<ForgetOfframpResponse> attestedMistySwapClientForgetOfframp({
    required ForgetOfframpRequest forgetOfframpRequest,
  }) async {
    return await MobileCoinFlutterPluginChannelApi.instance
        .attestedMistySwapClientForgetOfframp(
      mobileCoinClientId: id,
      forgetOfframpRequest: forgetOfframpRequest,
    );
  }
}
