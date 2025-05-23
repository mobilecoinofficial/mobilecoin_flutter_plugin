// Copyright (c) 2021-2024 MobileCoin. All rights reserved.

package com.mobilecoin.mobilecoin_flutter;

import android.net.Uri;
import android.util.Base64;

import androidx.annotation.Keep;
import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.mobilecoin.lib.AccountActivity;
import com.mobilecoin.lib.AccountKey;
import com.mobilecoin.lib.AccountSnapshot;
import com.mobilecoin.lib.AddressHash;
import com.mobilecoin.lib.Amount;
import com.mobilecoin.lib.Balance;
import com.mobilecoin.lib.ChaCha20Rng;
import com.mobilecoin.lib.ClientConfig;
import com.mobilecoin.lib.DefaultRng;
import com.mobilecoin.lib.DefragmentationDelegate;
import com.mobilecoin.lib.DestinationMemo;
import com.mobilecoin.lib.DestinationMemoData;
import com.mobilecoin.lib.DestinationWithPaymentIntentMemo;
import com.mobilecoin.lib.DestinationWithPaymentIntentMemoData;
import com.mobilecoin.lib.DestinationWithPaymentRequestMemo;
import com.mobilecoin.lib.DestinationWithPaymentRequestMemoData;
import com.mobilecoin.lib.MobileCoinClient;
import com.mobilecoin.lib.OwnedTxOut;
import com.mobilecoin.lib.PendingTransaction;
import com.mobilecoin.lib.PublicAddress;
import com.mobilecoin.lib.RandomLoadBalancer;
import com.mobilecoin.lib.RistrettoPublic;
import com.mobilecoin.lib.SenderMemo;
import com.mobilecoin.lib.SenderWithPaymentIntentMemo;
import com.mobilecoin.lib.SenderWithPaymentRequestMemo;
import com.mobilecoin.lib.SignedContingentInput;
import com.mobilecoin.lib.TokenId;
import com.mobilecoin.lib.Transaction;
import com.mobilecoin.lib.TxOutMemo;
import com.mobilecoin.lib.TxOutMemoBuilder;
import com.mobilecoin.lib.TxOutMemoType;
import com.mobilecoin.lib.UnsignedLong;
import com.mobilecoin.lib.TrustedIdentities;
import com.mobilecoin.lib.exceptions.AttestationException;
import com.mobilecoin.lib.exceptions.FeeRejectedException;
import com.mobilecoin.lib.exceptions.FogReportException;
import com.mobilecoin.lib.exceptions.FogSyncException;
import com.mobilecoin.lib.exceptions.FragmentedAccountException;
import com.mobilecoin.lib.exceptions.InsufficientFundsException;
import com.mobilecoin.lib.exceptions.InvalidFogResponse;
import com.mobilecoin.lib.exceptions.InvalidTransactionException;
import com.mobilecoin.lib.exceptions.InvalidTxOutMemoException;
import com.mobilecoin.lib.exceptions.InvalidUriException;
import com.mobilecoin.lib.exceptions.NetworkException;
import com.mobilecoin.lib.exceptions.SerializationException;
import com.mobilecoin.lib.exceptions.TransactionBuilderException;
import com.mobilecoin.lib.network.TransportProtocol;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.math.BigInteger;
import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;

import consensus_common.ConsensusCommon;
import mistyswap.AttestedMistySwapClient;
import mistyswap.MistySwapUri;

@Keep
public class FfiMobileCoinClient {

    private FfiMobileCoinClient() {}

    public static int create(int accountKeyId, String fogUrl, String consensusUrl,
            @Nullable String mistySwapUrl, boolean useTestNet, Integer clientConfigId) throws InvalidUriException, AttestationException {
        AccountKey accountKey = (AccountKey) ObjectStorage.objectForKey(accountKeyId);
        ClientConfig clientConfig = (ClientConfig) ObjectStorage.objectForKey(clientConfigId);
        MobileCoinClient mobileCoinClient = new MobileCoinClient(accountKey, Uri.parse(fogUrl),
                Uri.parse(consensusUrl), clientConfig, TransportProtocol.forGRPC());

        final int mobileCoinClientHashCode = mobileCoinClient.hashCode();
        ObjectStorage.addObject(mobileCoinClientHashCode, mobileCoinClient);

        if (!useTestNet && mistySwapUrl != null && !mistySwapUrl.isEmpty()) {
            AttestedMistySwapClient mistySwapClient = new AttestedMistySwapClient(
                    RandomLoadBalancer.create(new MistySwapUri(mistySwapUrl)),
                    new ClientConfig.Service().withTrustedIdentities((new TrustedIdentities())),
                    TransportProtocol.forGRPC());
            ObjectStorage.addObject(mistySwapClientHashCode(mobileCoinClientHashCode), mistySwapClient);
        }
        return mobileCoinClientHashCode;
    }

    static int mistySwapClientHashCode(int mobileCoinClientHashCode) {
        // TODO: will this work?
        return mobileCoinClientHashCode + 1;
    }

    public static String getBalance(int mobileClientId) throws InvalidFogResponse, NetworkException,
            AttestationException, FogSyncException, JSONException {
        MobileCoinClient mobileCoinClient =
                (MobileCoinClient) ObjectStorage.objectForKey(mobileClientId);
        Map<TokenId, Balance> balances = mobileCoinClient.getBalances();
        JSONObject result = new JSONObject();
        for (TokenId tokenId : balances.keySet()) {
            String balance = balances.get(tokenId).getValue().toString();
            result.put(tokenId.getId().toString(), balance);
        }
        return result.toString();
    }

    /**
     * Get the account activity for the given mobile client.
     *
     * @param mobileClientId The ID of the mobile client.
     * @param minTxOutBlockIndex The minimum block index of the TxOuts to include in the activity.
     * IMPORTANT NOTE: This referrs to either the received block index or the spent block index!
     * The purpose of this argument is to allow users to not receive TxOuts they have already seen,
     * and for which nothing has changed.
     * @return A JSON string representing the account activity.
     */
    public static String getAccountActivity(int mobileClientId, UnsignedLong minTxOutBlockIndex)
            throws NetworkException, InvalidFogResponse, AttestationException, JSONException,
            FogSyncException, TransactionBuilderException {
        MobileCoinClient mobileCoinClient =
                (MobileCoinClient) ObjectStorage.objectForKey(mobileClientId);
        AccountSnapshot snapshot = mobileCoinClient.getAccountSnapshot();
        Map<TokenId, Balance> balances = snapshot.getBalances();
        JSONObject result = new JSONObject();
        for (TokenId tokenId : balances.keySet()) {
            JSONObject activity = new JSONObject();
            Amount minFee = mobileCoinClient.getOrFetchMinimumTxFee(tokenId);
            Amount transferableAmount = snapshot.getTransferableAmount(minFee);
            String balance = snapshot.getBalance(tokenId).getValue().toString();
            AccountActivity accountActivity = snapshot.getAccountActivity();
            AccountKey accountKey = mobileCoinClient.getAccountKey();
            activity.put("balance", balance);
            activity.put("transferableAmount", transferableAmount.getValue().toString());
            activity.put("blockCount", accountActivity.getBlockCount());
            Set<OwnedTxOut> ownedTxOuts = accountActivity.getAllTokenTxOuts(tokenId).stream()
                .filter(txOut ->
                    txOut.getReceivedBlockIndex().compareTo(minTxOutBlockIndex) >= 0 ||
                    (txOut.getSpentBlockIndex() != null && txOut.getSpentBlockIndex().compareTo(minTxOutBlockIndex) >= 0)
                )
                .collect(Collectors.toSet());
            JSONArray txOuts = new JSONArray();
            for (OwnedTxOut txOut : ownedTxOuts) {
                JSONObject jsonTxOut = new JSONObject();
                jsonTxOut.put("value", txOut.getAmount().getValue().toString());

                if (txOut.getReceivedBlockTimestamp() != null) {
                    jsonTxOut.put("receivedDate", txOut.getReceivedBlockTimestamp().getTime());
                }

                jsonTxOut.put("receivedBlock", txOut.getReceivedBlockIndex().toString());
                jsonTxOut.put("publicKey",
                        Base64.encodeToString(txOut.getPublicKey().getKeyBytes(), Base64.NO_WRAP));
                jsonTxOut.put("keyImage",
                        Base64.encodeToString(txOut.getKeyImage().getData(), Base64.NO_WRAP));
                jsonTxOut.put("sharedSecret", Base64.encodeToString(
                        txOut.getSharedSecret(accountKey).getKeyBytes(), Base64.NO_WRAP));

                TxOutMemo txOutMemo = txOut.getTxOutMemo();
                try {
                    JSONObject jsonMemo = memoToJson(txOutMemo);
                    if (null != jsonMemo) {
                        jsonTxOut.put("memo", jsonMemo);
                    }
                } catch (Exception ignored) { /* skip unknown memos */ }

                if (txOut.getSpentBlockIndex() != null) {
                    jsonTxOut.put("spentBlock", txOut.getSpentBlockIndex().toString());

                    // spentBlockTimestamp is null when checking a spent TxOut before Fog Ledger
                    // knows it is spent
                    if (txOut.getSpentBlockTimestamp() != null) {
                        jsonTxOut.put("spentDate", txOut.getSpentBlockTimestamp().getTime());
                    }
                }
                txOuts.put(jsonTxOut);
            }
            activity.put("txOuts", txOuts);
            result.put(tokenId.getId().toString(), activity);
        }
        return result.toString();
    }


    @Nullable
    static JSONObject memoToJson(@NonNull TxOutMemo txOutMemo) throws JSONException, InvalidTxOutMemoException {
        JSONObject jsonMemoData = new JSONObject();
        final String memoTypeBytes;
        final String memoTypeName;
        final AddressHash addressHash;

        TxOutMemoType memoType = txOutMemo.getTxOutMemoType();
        switch (memoType) {
            case NOT_SET:
            case UNUSED:
            case UNKNOWN:
                return null;
            case SENDER:
                memoTypeBytes = "0100";
                memoTypeName = "SenderMemo";
                addressHash = ((SenderMemo)txOutMemo).getUnvalidatedAddressHash();
                break;
            case SENDER_WITH_PAYMENT_REQUEST:
                memoTypeBytes = "0101";
                memoTypeName = "SenderWithPaymentRequestIdMemo";
                SenderWithPaymentRequestMemo senderWithPaymentRequestMemo = (SenderWithPaymentRequestMemo)txOutMemo;
                UnsignedLong paymentRequestId = senderWithPaymentRequestMemo
                        .getUnvalidatedSenderWithPaymentRequestMemoData().getPaymentRequestId();
                addressHash = senderWithPaymentRequestMemo.getUnvalidatedAddressHash();
                jsonMemoData.put("paymentRequestId", paymentRequestId.toString());
                break;
            case SENDER_WITH_PAYMENT_INTENT:
                memoTypeBytes = "0102";
                memoTypeName = "SenderWithPaymentIntentIdMemo";
                addressHash = ((SenderWithPaymentIntentMemo)txOutMemo).getUnvalidatedAddressHash();
                SenderWithPaymentIntentMemo senderWithPaymentIntentMemo = (SenderWithPaymentIntentMemo)txOutMemo;
                UnsignedLong paymentIntentId = senderWithPaymentIntentMemo
                        .getUnvalidatedSenderWithPaymentIntentMemoData().getPaymentIntentId();
                jsonMemoData.put("paymentIntentId", paymentIntentId.toString());
                break;
            case DESTINATION:
                memoTypeBytes = "0200";
                memoTypeName = "DestinationMemo";
                    DestinationMemoData destinationMemoData = ((DestinationMemo) txOutMemo).getDestinationMemoData();
                    addressHash = destinationMemoData.getAddressHash();
                    jsonMemoData.put("fee", destinationMemoData.getFee().toString());
                    jsonMemoData.put("totalOutlay", destinationMemoData.getTotalOutlay().toString());
                    jsonMemoData.put("numberOfRecipients", String.valueOf(destinationMemoData.getNumberOfRecipients()));
                break;
            case DESTINATION_WITH_PAYMENT_REQUEST:
                memoTypeBytes = "0203";
                memoTypeName = "DestinationWithPaymentRequestIdMemo";
                DestinationWithPaymentRequestMemoData destinationWithPaymentRequestMemoData = ((DestinationWithPaymentRequestMemo)txOutMemo).getDestinationWithPaymentRequestMemoData();
                addressHash = destinationWithPaymentRequestMemoData.getAddressHash();
                jsonMemoData.put("fee", destinationWithPaymentRequestMemoData.getFee().toString());
                jsonMemoData.put("totalOutlay", destinationWithPaymentRequestMemoData.getTotalOutlay().toString());
                jsonMemoData.put("numberOfRecipients", String.valueOf(destinationWithPaymentRequestMemoData.getNumberOfRecipients()));
                jsonMemoData.put("paymentRequestId", destinationWithPaymentRequestMemoData.getPaymentRequestId().toString());
                break;
            case DESTINATION_WITH_PAYMENT_INTENT:
                memoTypeBytes = "0204";
                memoTypeName = "DestinationWithPaymentIntentIdMemo";
                DestinationWithPaymentIntentMemoData destinationWithPaymentIntentMemoData = ((DestinationWithPaymentIntentMemo)txOutMemo).getDestinationWithPaymentIntentMemoData();
                addressHash = destinationWithPaymentIntentMemoData.getAddressHash();
                jsonMemoData.put("fee", destinationWithPaymentIntentMemoData.getFee().toString());
                jsonMemoData.put("totalOutlay", destinationWithPaymentIntentMemoData.getTotalOutlay().toString());
                jsonMemoData.put("numberOfRecipients", String.valueOf(destinationWithPaymentIntentMemoData.getNumberOfRecipients()));
                jsonMemoData.put("paymentIntentId", destinationWithPaymentIntentMemoData.getPaymentIntentId().toString());
                break;
            default:
                // skip unknown memo
                return null;
        }
        String addressHashHex = bytesToHex(addressHash.getHashData());
        jsonMemoData.put("addressHashHex", addressHashHex);

        JSONObject jsonMemo = new JSONObject();
        jsonMemo.put("typeBytes", memoTypeBytes);
        jsonMemo.put("typeName", memoTypeName);
        jsonMemo.put("data", jsonMemoData);
        return jsonMemo;
    }

    private static final byte[] HEX_ARRAY = "0123456789abcdef".getBytes(StandardCharsets.US_ASCII);

    private static String bytesToHex(byte[] bytes) {
        byte[] hexChars = new byte[bytes.length * 2];
        for (int j = 0; j < bytes.length; j++) {
            int v = bytes[j] & 0xFF;
            hexChars[j * 2] = HEX_ARRAY[v >>> 4];
            hexChars[j * 2 + 1] = HEX_ARRAY[v & 0x0F];
        }
        return new String(hexChars, StandardCharsets.UTF_8);
    }

    public static void setAuthorization(int mobileClientId, @NonNull String username,
            @NonNull String password) {
        MobileCoinClient mobileCoinClient =
                (MobileCoinClient) ObjectStorage.objectForKey(mobileClientId);
        mobileCoinClient.setFogBasicAuthorization(username, password);
    }

    public static int checkTransactionStatus(int mobileClientId, int receiptId)
            throws AttestationException, InvalidFogResponse, NetworkException, FogSyncException {
        MobileCoinClient mobileCoinClient =
                (MobileCoinClient) ObjectStorage.objectForKey(mobileClientId);
        Transaction transaction = (Transaction) ObjectStorage.objectForKey(receiptId);

        // more race condition testing will need to be done before changing this to
        // `getTransactionStatusQuick`
        Transaction.Status status = mobileCoinClient.getTransactionStatus(transaction);
        switch (status) {
            case ACCEPTED:
                return 1;
            case FAILED:
                return 2;
            case UNKNOWN:
            default:
                return 0;
        }
    }

    @Nullable
    static UnsignedLong tryParseLong(String value) {
        try {
            return UnsignedLong.fromBigInteger(new BigInteger(value));
        } catch (Exception e) {
            return null;
        }
    }

    public static HashMap<String, Object> createPendingTransaction(int mobileClientId,
            int recipientId, @NonNull PicoMob fee, @NonNull PicoMob amount,
            @NonNull TokenId tokenId, byte[] rngSeed, String paymentRequestIdString) throws InvalidFogResponse,
            AttestationException, FeeRejectedException, InsufficientFundsException,
            FragmentedAccountException, NetworkException, TransactionBuilderException,
            FogReportException, FogSyncException, SerializationException {
        PublicAddress recipient = (PublicAddress) ObjectStorage.objectForKey(recipientId);
        MobileCoinClient mobileCoinClient =
                (MobileCoinClient) ObjectStorage.objectForKey(mobileClientId);
        final UnsignedLong paymentRequestId = tryParseLong(paymentRequestIdString);
        TxOutMemoBuilder txOutMemoBuilder = paymentRequestId == null ?
                TxOutMemoBuilder
                        .createSenderAndDestinationRTHMemoBuilder(mobileCoinClient.getAccountKey()) :
                TxOutMemoBuilder
                        .createSenderPaymentRequestAndDestinationRTHMemoBuilder(mobileCoinClient.getAccountKey(), paymentRequestId);

        // Reusing an rngSeed makes it so the public key is always the same, ensuring
        // idempotence
        ChaCha20Rng rng = ChaCha20Rng.fromSeed(rngSeed);

        final PendingTransaction pendingTransaction = mobileCoinClient.prepareTransaction(recipient,
                new Amount(amount.getPicoCountAsBigInt(), tokenId),
                new Amount(fee.getPicoCountAsBigInt(), tokenId), txOutMemoBuilder, rng);

        HashMap<String, Object> returnPayload = new HashMap<>();
        returnPayload.put("transaction", pendingTransaction.getTransaction().toByteArray());

        final RistrettoPublic payloadTxOutPublicKey =
                pendingTransaction.getPayloadTxOutContext().getTxOutPublicKey();
        final RistrettoPublic payloadTxOutSharedSecret =
                pendingTransaction.getPayloadTxOutContext().getSharedSecret();
        final RistrettoPublic changeTxOutPublicKey =
                pendingTransaction.getChangeTxOutContext().getTxOutPublicKey();
        final RistrettoPublic changeTxOutSharedSecret =
                pendingTransaction.getChangeTxOutContext().getSharedSecret();

        returnPayload.put("payloadTxOutPublicKey",
                Base64.encodeToString(payloadTxOutPublicKey.getKeyBytes(), Base64.NO_WRAP));
        returnPayload.put("payloadTxOutSharedSecret",
                Base64.encodeToString(payloadTxOutSharedSecret.getKeyBytes(), Base64.NO_WRAP));
        returnPayload.put("changeTxOutPublicKey",
                Base64.encodeToString(changeTxOutPublicKey.getKeyBytes(), Base64.NO_WRAP));
        returnPayload.put("changeTxOutSharedSecret",
                Base64.encodeToString(changeTxOutSharedSecret.getKeyBytes(), Base64.NO_WRAP));

        return returnPayload;
    }

    public static String sendFunds(int mobileClientId, byte[] serializedTransaction)
            throws SerializationException, JSONException {
        MobileCoinClient mobileCoinClient =
                (MobileCoinClient) ObjectStorage.objectForKey(mobileClientId);
        Transaction transaction = Transaction.fromBytes(serializedTransaction);
        int receiptId = transaction.hashCode();

        ObjectStorage.addObject(receiptId, transaction);

        JSONObject resultObject = new JSONObject();

        try {
            final long blockIndex = mobileCoinClient.submitTransaction(transaction);

            resultObject.put("status", "OK");
            resultObject.put("blockIndex", blockIndex);
            resultObject.put("receiptId", receiptId);
        } catch (InvalidTransactionException e) {
            final ConsensusCommon.ProposeTxResult result =
                    e.getResult() == null ? ConsensusCommon.ProposeTxResult.UNRECOGNIZED
                            : e.getResult();

            resultObject.put("blockIndex", e.getBlockIndex());

            switch (result) {
                case ContainsSpentKeyImage:
                case ContainsExistingOutputPublicKey:
                    resultObject.put("status", "INPUT_ALREADY_SPENT");
                case TxFeeError:
                    resultObject.put("status", "FEE_ERROR");
                case MissingMemo:
                    resultObject.put("status", "MISSING_MEMO");
                case TombstoneBlockTooFar:
                    resultObject.put("status", "TOMBSTONE_BLOCK_TOO_FAR");
                default:
                    resultObject.put("status", "INVALID_TRANSACTION");
            }
        } catch (NetworkException e) {
            resultObject.put("status", "NETWORK_ERROR");
        } catch (AttestationException e) {
            resultObject.put("status", "ATTESTATION_EXCEPTION");
        }

        return resultObject.toString();
    }

    public static boolean requiresDefragmentation(int mobileClientId,
        @NonNull BigInteger amount, @NonNull TokenId tokenId) throws Exception {
        MobileCoinClient mobileCoinClient =
                (MobileCoinClient) ObjectStorage.objectForKey(mobileClientId);
        return mobileCoinClient.requiresDefragmentation(
            new Amount(amount, tokenId)
        );
    }

    public static void defragmentAccount(int mobileClientId,
        @NonNull BigInteger amount, @NonNull TokenId tokenId,
    boolean shouldWriteRTHMemos, @Nullable byte[] rngSeed
    ) throws Exception {
        MobileCoinClient mobileCoinClient =
                (MobileCoinClient) ObjectStorage.objectForKey(mobileClientId);

        DefragmentationDelegate defragDelegate = new DefragmentationDelegate() {
            @Override
            public void onStart() { }

            @Override
            public boolean onStepReady(@NonNull PendingTransaction defragStepTx,
                                       @NonNull BigInteger fee) throws NetworkException,
                    InvalidTransactionException, AttestationException {
                mobileCoinClient.submitTransaction(defragStepTx.getTransaction());
                return true;
            }

            @Override
            public void onComplete() { }

            @Override
            public void onCancel() { }
        };

        Amount tokenAmount = new Amount(amount, tokenId);
        if (null == rngSeed || rngSeed.length < 32) {
            mobileCoinClient.defragmentAccount(tokenAmount, defragDelegate, shouldWriteRTHMemos, DefaultRng.createInstance());
        } else {
            ChaCha20Rng rng = ChaCha20Rng.fromSeed(rngSeed);
            mobileCoinClient.defragmentAccount(tokenAmount, defragDelegate, shouldWriteRTHMemos, rng);
        }
    }

    public static String estimateTotalFee(int mobileClientId,
        @NonNull BigInteger amount, @NonNull TokenId tokenId
    ) throws Exception {
        MobileCoinClient mobileCoinClient =
                (MobileCoinClient) ObjectStorage.objectForKey(mobileClientId);

        Amount tokenAmount = new Amount(amount, tokenId);
        Amount fee = mobileCoinClient.estimateTotalFee(tokenAmount);
        return fee.getValue().toString();
    }

    public static String getTransferableAmount(
            int mobileClientId,
            @NonNull TokenId tokenId
    ) throws Exception {
        MobileCoinClient mobileCoinClient =
                (MobileCoinClient) ObjectStorage.objectForKey(mobileClientId);

        Amount amount = mobileCoinClient.getTransferableAmount(tokenId);
        return amount.getValue().toString();
    }

    public static HashMap<String, Object> createProofOfReserveSignedContingentInput(int mobileClientId, byte[] txOutPublicKeyBytes) throws Exception {
        MobileCoinClient mobileCoinClient =
                (MobileCoinClient) ObjectStorage.objectForKey(mobileClientId);

        SignedContingentInput sci =  mobileCoinClient.createProofOfReserveSignedContingentInput(txOutPublicKeyBytes);

        HashMap<String, Object> returnPayload = new HashMap<>();
        returnPayload.put("sciProtobufBytes", sci.toByteArray());

        return returnPayload;
    }
}
