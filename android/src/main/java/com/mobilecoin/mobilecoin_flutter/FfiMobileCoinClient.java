package com.mobilecoin.mobilecoin_flutter;

import android.net.Uri;

import android.util.Base64;
import androidx.annotation.Keep;
import androidx.annotation.NonNull;

import com.mobilecoin.lib.AccountKey;
import com.mobilecoin.lib.Amount;
import com.mobilecoin.lib.MobileCoinClient;
import com.mobilecoin.lib.PendingTransaction;
import com.mobilecoin.lib.PublicAddress;
import com.mobilecoin.lib.RistrettoPublic;
import com.mobilecoin.lib.TokenId;
import com.mobilecoin.lib.Transaction;
import com.mobilecoin.lib.AccountActivity;
import com.mobilecoin.lib.OwnedTxOut;
import com.mobilecoin.lib.AccountSnapshot;
import com.mobilecoin.lib.TxOutMemoBuilder;
import com.mobilecoin.lib.exceptions.AttestationException;
import com.mobilecoin.lib.exceptions.FeeRejectedException;
import com.mobilecoin.lib.exceptions.FogSyncException;
import com.mobilecoin.lib.exceptions.FragmentedAccountException;
import com.mobilecoin.lib.exceptions.InsufficientFundsException;
import com.mobilecoin.lib.exceptions.InvalidFogResponse;
import com.mobilecoin.lib.exceptions.InvalidTransactionException;
import com.mobilecoin.lib.exceptions.NetworkException;
import com.mobilecoin.lib.exceptions.FogReportException;
import com.mobilecoin.lib.exceptions.TransactionBuilderException;
import com.mobilecoin.lib.exceptions.InvalidUriException;
import com.mobilecoin.lib.network.TransportProtocol;

import java.text.SimpleDateFormat;

import org.json.JSONException;
import java.math.BigInteger;
import org.json.JSONArray;
import org.json.JSONObject;

import java.util.Locale;
import java.util.Set;
import java.util.Date;

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

    public static String sendFunds(int mobileClientId, int recipientId, @NonNull PicoMob fee, @NonNull PicoMob amount)
            throws InvalidTransactionException, InsufficientFundsException, AttestationException, InvalidFogResponse,
            FragmentedAccountException, FeeRejectedException, NetworkException,
            TransactionBuilderException, FogReportException, JSONException, FogSyncException {
        PublicAddress recipient = (PublicAddress) ObjectStorage.objectForKey(recipientId);
        MobileCoinClient mobileCoinClient = (MobileCoinClient) ObjectStorage.objectForKey(mobileClientId);
        TxOutMemoBuilder txOutMemoBuilder = TxOutMemoBuilder.createSenderAndDestinationRTHMemoBuilder(mobileCoinClient.getAccountKey());

        final PendingTransaction pending = mobileCoinClient.prepareTransaction(recipient, new Amount(amount.getPicoCountAsBigInt(), TokenId.MOB),
                new Amount(fee.getPicoCountAsBigInt(), TokenId.MOB), txOutMemoBuilder);
        mobileCoinClient.submitTransaction(pending.getTransaction());

        Transaction transaction = pending.getTransaction();

        JSONObject receiptObject = new JSONObject();

        final int transactionHashCode = transaction.hashCode();
        ObjectStorage.addObject(transactionHashCode, transaction);
        receiptObject.put("receiptId", transactionHashCode);


        final RistrettoPublic payloadTxOutPublicKey = pending.getPayloadTxOutContext().getTxOutPublicKey();
        final RistrettoPublic payloadTxOutSharedSecret = pending.getPayloadTxOutContext().getSharedSecret();
        final RistrettoPublic changeTxOutPublicKey = pending.getChangeTxOutContext().getTxOutPublicKey();
        final RistrettoPublic changeTxOutSharedSecret = pending.getChangeTxOutContext().getSharedSecret();

        receiptObject.put("payloadTxOutPublicKey", Base64.encodeToString(payloadTxOutPublicKey.getKeyBytes(), Base64.NO_WRAP));
        receiptObject.put("payloadTxOutSharedSecret", Base64.encodeToString(payloadTxOutSharedSecret.getKeyBytes(), Base64.NO_WRAP));
        receiptObject.put("changeTxOutPublicKey", Base64.encodeToString(changeTxOutPublicKey.getKeyBytes(), Base64.NO_WRAP));
        receiptObject.put("changeTxOutSharedSecret", Base64.encodeToString(changeTxOutSharedSecret.getKeyBytes(), Base64.NO_WRAP));

        return receiptObject.toString();
    }
}
