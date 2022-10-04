package com.mobilecoin.mobilecoin_flutter;

import android.net.Uri;
import android.util.Base64;

import androidx.annotation.Keep;
import androidx.annotation.NonNull;

import com.mobilecoin.lib.AccountActivity;
import com.mobilecoin.lib.AccountKey;
import com.mobilecoin.lib.AccountSnapshot;
import com.mobilecoin.lib.Amount;
import com.mobilecoin.lib.Balance;
import com.mobilecoin.lib.ChaCha20Rng;
import com.mobilecoin.lib.MobileCoinClient;
import com.mobilecoin.lib.OwnedTxOut;
import com.mobilecoin.lib.PendingTransaction;
import com.mobilecoin.lib.PublicAddress;
import com.mobilecoin.lib.RistrettoPublic;
import com.mobilecoin.lib.TokenId;
import com.mobilecoin.lib.Transaction;
import com.mobilecoin.lib.TxOutMemoBuilder;
import com.mobilecoin.lib.exceptions.AttestationException;
import com.mobilecoin.lib.exceptions.FeeRejectedException;
import com.mobilecoin.lib.exceptions.FogReportException;
import com.mobilecoin.lib.exceptions.FogSyncException;
import com.mobilecoin.lib.exceptions.FragmentedAccountException;
import com.mobilecoin.lib.exceptions.InsufficientFundsException;
import com.mobilecoin.lib.exceptions.InvalidFogResponse;
import com.mobilecoin.lib.exceptions.InvalidTransactionException;
import com.mobilecoin.lib.exceptions.InvalidUriException;
import com.mobilecoin.lib.exceptions.NetworkException;
import com.mobilecoin.lib.exceptions.SerializationException;
import com.mobilecoin.lib.exceptions.TransactionBuilderException;
import com.mobilecoin.lib.network.TransportProtocol;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;
import java.util.Set;

import consensus_common.ConsensusCommon;

@Keep
public class FfiMobileCoinClient {

    private FfiMobileCoinClient() {
    }

    public static int create(int accountKeyId, String fogUrl, String consensusUrl, boolean useTestNet)
            throws InvalidUriException {
        AccountKey accountKey = (AccountKey) ObjectStorage.objectForKey(accountKeyId);

        MobileCoinClient mobileCoinClient = new MobileCoinClient(accountKey, Uri.parse(fogUrl),
                Uri.parse(consensusUrl), TransportProtocol.forGRPC());

        final int hashCode = mobileCoinClient.hashCode();
        ObjectStorage.addObject(hashCode, mobileCoinClient);
        return hashCode;
    }

    public static String getBalance(int mobileClientId)
            throws InvalidFogResponse, NetworkException, AttestationException, FogSyncException, JSONException {
        MobileCoinClient mobileCoinClient = (MobileCoinClient) ObjectStorage.objectForKey(mobileClientId);
        Map<TokenId, Balance> balances = mobileCoinClient.getBalances();
        JSONObject result = new JSONObject();
        for (TokenId tokenId: balances.keySet()) {
                String balance = balances.get(tokenId).getValue().toString();
                result.put(tokenId.getId().toString(), balance);
            }
        return result.toString();
    }

    public static String getAccountActivity(int mobileClientId)
            throws NetworkException, InvalidFogResponse, AttestationException, JSONException, FogSyncException, TransactionBuilderException {
        MobileCoinClient mobileCoinClient = (MobileCoinClient) ObjectStorage.objectForKey(mobileClientId);
        AccountSnapshot snapshot = mobileCoinClient.getAccountSnapshot();
        Map<TokenId, Balance> balances = snapshot.getBalances();
        JSONObject result = new JSONObject();
        for (TokenId tokenId : balances.keySet()) {
            JSONObject activity = new JSONObject();
            String balance = snapshot.getBalance(tokenId).getValue().toString();
            AccountActivity accountActivity = snapshot.getAccountActivity();
            AccountKey accountKey = mobileCoinClient.getAccountKey();
            activity.put("balance", balance);
            activity.put("blockCount", accountActivity.getBlockCount());
            Set<OwnedTxOut> ownedTxOuts = accountActivity.getAllTokenTxOuts(tokenId);
            JSONArray txOuts = new JSONArray();
            for (OwnedTxOut txOut : ownedTxOuts) {
                JSONObject jsonTxOut = new JSONObject();
                jsonTxOut.put("value", txOut.getAmount().getValue().toString());
                jsonTxOut.put("receivedDate", formatDate(txOut.getReceivedBlockTimestamp()));
                jsonTxOut.put("receivedBlock", txOut.getReceivedBlockIndex().toString());
                jsonTxOut.put("publicKey", Base64.encodeToString(txOut.getPublicKey().getKeyBytes(), Base64.NO_WRAP));
                jsonTxOut.put("keyImage", Base64.encodeToString(txOut.getKeyImage().getData(), Base64.NO_WRAP));
                jsonTxOut.put("sharedSecret", Base64.encodeToString(txOut.getSharedSecret(accountKey).getKeyBytes(), Base64.NO_WRAP));
                if (txOut.getSpentBlockIndex() != null) {
                    jsonTxOut.put("spentBlock", txOut.getSpentBlockIndex().toString());

                    // spentBlockTimestamp is null when checking a spent TxOut before Fog Ledger knows it is spent
                    if (txOut.getSpentBlockTimestamp() != null) {
                        jsonTxOut.put("spentDate", formatDate(txOut.getSpentBlockTimestamp()));
                    }
                }
                txOuts.put(jsonTxOut);
            }
            activity.put("txOuts", txOuts);
            result.put(tokenId.getId().toString(), activity);
        }
        return result.toString();
    }

    private static String formatDate(Date date) {
        return new SimpleDateFormat("MM/dd/yyyy KK:mm:ss a Z", Locale.US).format(date);
    }

    public static void setAuthorization(int mobileClientId, @NonNull String username, @NonNull String password) {
        MobileCoinClient mobileCoinClient = (MobileCoinClient) ObjectStorage.objectForKey(mobileClientId);
        mobileCoinClient.setFogBasicAuthorization(username, password);
    }

    public static int checkTransactionStatus(int mobileClientId, int receiptId)
            throws AttestationException, InvalidFogResponse, NetworkException, FogSyncException {
        MobileCoinClient mobileCoinClient = (MobileCoinClient) ObjectStorage.objectForKey(mobileClientId);
        Transaction transaction = (Transaction) ObjectStorage.objectForKey(receiptId);

        // more race condition testing will need to be done before changing this to `getTransactionStatusQuick`
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

    public static HashMap<String, Object> createPendingTransaction(int mobileClientId, int recipientId, @NonNull PicoMob fee, @NonNull PicoMob amount, @NonNull TokenId tokenId, byte[] rngSeed)
            throws InvalidFogResponse, AttestationException, FeeRejectedException, InsufficientFundsException,
            FragmentedAccountException, NetworkException, TransactionBuilderException, FogReportException,
            FogSyncException, SerializationException {
        PublicAddress recipient = (PublicAddress) ObjectStorage.objectForKey(recipientId);
        MobileCoinClient mobileCoinClient = (MobileCoinClient) ObjectStorage.objectForKey(mobileClientId);
        TxOutMemoBuilder txOutMemoBuilder = TxOutMemoBuilder.createSenderAndDestinationRTHMemoBuilder(mobileCoinClient.getAccountKey());

        // Reusing an rngSeed makes it so the public key is always the same, ensuring idempotence
        ChaCha20Rng rng = ChaCha20Rng.fromSeed(rngSeed);

        final PendingTransaction pendingTransaction = mobileCoinClient.prepareTransaction(recipient, new Amount(amount.getPicoCountAsBigInt(), tokenId),
                new Amount(fee.getPicoCountAsBigInt(), tokenId), txOutMemoBuilder, rng);

        HashMap<String, Object> returnPayload = new HashMap<>();
        returnPayload.put("transaction", pendingTransaction.getTransaction().toByteArray());

        final RistrettoPublic payloadTxOutPublicKey = pendingTransaction.getPayloadTxOutContext().getTxOutPublicKey();
        final RistrettoPublic payloadTxOutSharedSecret = pendingTransaction.getPayloadTxOutContext().getSharedSecret();
        final RistrettoPublic changeTxOutPublicKey = pendingTransaction.getChangeTxOutContext().getTxOutPublicKey();
        final RistrettoPublic changeTxOutSharedSecret = pendingTransaction.getChangeTxOutContext().getSharedSecret();

        returnPayload.put("payloadTxOutPublicKey", Base64.encodeToString(payloadTxOutPublicKey.getKeyBytes(), Base64.NO_WRAP));
        returnPayload.put("payloadTxOutSharedSecret", Base64.encodeToString(payloadTxOutSharedSecret.getKeyBytes(), Base64.NO_WRAP));
        returnPayload.put("changeTxOutPublicKey", Base64.encodeToString(changeTxOutPublicKey.getKeyBytes(), Base64.NO_WRAP));
        returnPayload.put("changeTxOutSharedSecret", Base64.encodeToString(changeTxOutSharedSecret.getKeyBytes(), Base64.NO_WRAP));

        return returnPayload;
    }

    public static String sendFunds(int mobileClientId, byte[] serializedTransaction)
            throws SerializationException, JSONException {
        MobileCoinClient mobileCoinClient = (MobileCoinClient) ObjectStorage.objectForKey(mobileClientId);
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
            final ConsensusCommon.ProposeTxResult result = e.getResult() == null ?
                    ConsensusCommon.ProposeTxResult.UNRECOGNIZED :
                    e.getResult();

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
}
