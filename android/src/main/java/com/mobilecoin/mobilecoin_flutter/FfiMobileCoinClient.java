package com.mobilecoin.mobilecoin_flutter;

import android.net.Uri;
import android.util.Base64;

import androidx.annotation.Keep;
import androidx.annotation.NonNull;

import com.mobilecoin.lib.AccountActivity;
import com.mobilecoin.lib.AccountKey;
import com.mobilecoin.lib.AccountSnapshot;
import com.mobilecoin.lib.Amount;
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
import com.mobilecoin.lib.exceptions.TransactionBuilderException;
import com.mobilecoin.lib.network.TransportProtocol;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.math.BigInteger;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;
import java.util.Objects;
import java.util.Set;

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

    public static BigInteger getBalance(int mobileClientId)
            throws InvalidFogResponse, NetworkException, AttestationException, FogSyncException {
        MobileCoinClient mobileCoinClient = (MobileCoinClient) ObjectStorage.objectForKey(mobileClientId);
        return mobileCoinClient.getBalance(TokenId.MOB).getValue();
    }

    public static String getAccountActivity(int mobileClientId)
            throws NetworkException, InvalidFogResponse, AttestationException, JSONException, FogSyncException, TransactionBuilderException {
        MobileCoinClient mobileCoinClient = (MobileCoinClient) ObjectStorage.objectForKey(mobileClientId);
        AccountSnapshot snapshot = mobileCoinClient.getAccountSnapshot();
        JSONObject result = new JSONObject();
        String balance = snapshot.getBalance(TokenId.MOB).getValue().toString();
        AccountActivity activity = snapshot.getAccountActivity();
        AccountKey accountKey = mobileCoinClient.getAccountKey();
        result.put("balance", balance);
        result.put("blockCount", activity.getBlockCount());
        Set<OwnedTxOut> ownedTxOuts = activity.getAllTxOuts();
        JSONArray txOuts = new JSONArray();
        for (OwnedTxOut txOut : ownedTxOuts) {
            JSONObject jsonTxOut = new JSONObject();
            jsonTxOut.put("value", txOut.getValue().toString());
            jsonTxOut.put("receivedDate", formatDate(txOut.getReceivedBlockTimestamp()));
            jsonTxOut.put("receivedBlock", txOut.getReceivedBlockIndex().toString());
            jsonTxOut.put("publicKey", Base64.encodeToString(txOut.getPublicKey().getKeyBytes(), Base64.NO_WRAP));
            jsonTxOut.put("keyImage", Base64.encodeToString(txOut.getKeyImage().getData(), Base64.NO_WRAP));
            jsonTxOut.put("sharedSecret", Base64.encodeToString(txOut.getSharedSecret(accountKey).getKeyBytes(), Base64.NO_WRAP));
            if (txOut.getSpentBlockIndex() != null && txOut.getSpentBlockTimestamp() != null) {
                jsonTxOut.put("spentDate", formatDate(txOut.getSpentBlockTimestamp()));
                jsonTxOut.put("spentBlock", txOut.getSpentBlockIndex().toString());
            }
            txOuts.put(jsonTxOut);
        }
        result.put("txOuts", txOuts);
        return result.toString();
    }

    private static String formatDate(Date date) {
        return new SimpleDateFormat("MM/dd/yyyy KK:mm:ss a Z", Locale.US).format(date);
    }

    public static void setAuthorization(int mobileClientId, @NonNull String username, @NonNull String password) {
        MobileCoinClient mobileCoinClient = (MobileCoinClient) ObjectStorage.objectForKey(mobileClientId);
        mobileCoinClient.setFogBasicAuthorization(username, password);
    }

    public static int checkTransactionStatus(int mobileClientId, int transactionId) throws AttestationException, InvalidFogResponse, NetworkException, FogSyncException {
        MobileCoinClient mobileCoinClient = (MobileCoinClient) ObjectStorage.objectForKey(mobileClientId);
        Transaction transaction = (Transaction) ObjectStorage.objectForKey(transactionId);

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

    public static String createPendingTransaction(int mobileClientId, int recipientId, @NonNull PicoMob fee, @NonNull PicoMob amount)
            throws InvalidFogResponse, AttestationException, FeeRejectedException, InsufficientFundsException,
            FragmentedAccountException, NetworkException, TransactionBuilderException, FogReportException,
            JSONException, FogSyncException {
        PublicAddress recipient = (PublicAddress) ObjectStorage.objectForKey(recipientId);
        MobileCoinClient mobileCoinClient = (MobileCoinClient) ObjectStorage.objectForKey(mobileClientId);
        TxOutMemoBuilder txOutMemoBuilder = TxOutMemoBuilder.createSenderAndDestinationRTHMemoBuilder(mobileCoinClient.getAccountKey());

        final PendingTransaction pendingTransaction = mobileCoinClient.prepareTransaction(recipient, new Amount(amount.getPicoCountAsBigInt(), TokenId.MOB),
                new Amount(fee.getPicoCountAsBigInt(), TokenId.MOB), txOutMemoBuilder);

        final int hashCode = pendingTransaction.getPayloadTxOutContext().hashCode();
        ObjectStorage.addObject(hashCode, pendingTransaction);

        JSONObject transactionObject = new JSONObject();
        transactionObject.put("pendingTransactionId", hashCode);

        final RistrettoPublic payloadTxOutPublicKey = pendingTransaction.getPayloadTxOutContext().getTxOutPublicKey();
        final RistrettoPublic payloadTxOutSharedSecret = pendingTransaction.getPayloadTxOutContext().getSharedSecret();
        final RistrettoPublic changeTxOutPublicKey = pendingTransaction.getChangeTxOutContext().getTxOutPublicKey();
        final RistrettoPublic changeTxOutSharedSecret = pendingTransaction.getChangeTxOutContext().getSharedSecret();

        transactionObject.put("payloadTxOutPublicKey", Base64.encodeToString(payloadTxOutPublicKey.getKeyBytes(), Base64.NO_WRAP));
        transactionObject.put("payloadTxOutSharedSecret", Base64.encodeToString(payloadTxOutSharedSecret.getKeyBytes(), Base64.NO_WRAP));
        transactionObject.put("changeTxOutPublicKey", Base64.encodeToString(changeTxOutPublicKey.getKeyBytes(), Base64.NO_WRAP));
        transactionObject.put("changeTxOutSharedSecret", Base64.encodeToString(changeTxOutSharedSecret.getKeyBytes(), Base64.NO_WRAP));

        return transactionObject.toString();
    }

    public static String sendFunds(int mobileClientId, int pendingTransactionId)
            throws JSONException, FlutterError {
        MobileCoinClient mobileCoinClient = (MobileCoinClient) ObjectStorage.objectForKey(mobileClientId);
        PendingTransaction pendingTransaction = (PendingTransaction) ObjectStorage.objectForKey(pendingTransactionId);
        Transaction transaction = pendingTransaction.getTransaction();

        try {
            mobileCoinClient.submitTransaction(transaction);
        } catch (InvalidTransactionException e) {
            switch (Objects.requireNonNull(e.getMessage())) {
            case "ContainsSpentKeyImage":
                throw new FlutterError("NATIVE", "INPUT_ALREADY_SPENT", e.getMessage());
            case "TxFeeError":
                throw new FlutterError("NATIVE", "FEE_ERROR", e.getMessage());
            case "MissingMemo":
                throw new FlutterError("NATIVE", "MISSING_MEMO", e.getMessage());
            case "TombstoneBlockTooFar":
                throw new FlutterError("NATIVE", "TOMBSTONE_BLOCK_TOO_FAR", e.getMessage());
            default:
                throw new FlutterError("NATIVE", "INVALID_TRANSACTION", e.getMessage());
            }
        } catch (NetworkException e) {
            throw new FlutterError("NATIVE", "NETWORK_ERROR", e.getMessage());
        } catch (AttestationException e) {
            throw new FlutterError("NATIVE", "ATTESTATION_EXCEPTION", e.getMessage());
        }

        final int transactionHashCode = transaction.hashCode();
        ObjectStorage.addObject(transactionHashCode, transaction);

        JSONObject receiptObject = new JSONObject();
        receiptObject.put("receiptId", transactionHashCode);

        return receiptObject.toString();
    }
}
