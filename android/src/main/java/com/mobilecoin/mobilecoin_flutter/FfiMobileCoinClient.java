package com.mobilecoin.mobilecoin_flutter;

import android.net.Uri;

import android.util.Base64;
import androidx.annotation.Keep;
import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.mobilecoin.lib.AccountKey;
import com.mobilecoin.lib.MobileCoinClient;
import com.mobilecoin.lib.PendingTransaction;
import com.mobilecoin.lib.PublicAddress;
import com.mobilecoin.lib.Receipt;
import com.mobilecoin.lib.Transaction;
import com.mobilecoin.lib.AccountActivity;
import com.mobilecoin.lib.OwnedTxOut;
import com.mobilecoin.lib.AccountSnapshot;
import com.mobilecoin.lib.exceptions.AttestationException;
import com.mobilecoin.lib.exceptions.FeeRejectedException;
import com.mobilecoin.lib.exceptions.FragmentedAccountException;
import com.mobilecoin.lib.exceptions.InsufficientFundsException;
import com.mobilecoin.lib.exceptions.InvalidFogResponse;
import com.mobilecoin.lib.exceptions.InvalidTransactionException;
import com.mobilecoin.lib.exceptions.NetworkException;
import com.mobilecoin.lib.exceptions.FogReportException;
import com.mobilecoin.lib.exceptions.TransactionBuilderException;
import com.mobilecoin.lib.exceptions.InvalidUriException;
import java.text.SimpleDateFormat;

import org.json.JSONException;
import java.math.BigDecimal;
import java.math.BigInteger;
import org.json.JSONArray;
import org.json.JSONObject;
import java.util.Set;
import java.util.Date;

@Keep
public class FfiMobileCoinClient {

    private FfiMobileCoinClient() {
    }

    public static int create(int accountKeyId, String fogUrl, String consensusUrl) throws InvalidUriException {
        AccountKey accountKey = (AccountKey) ObjectStorage.objectForKey(accountKeyId);

        MobileCoinClient mobileCoinClient = new MobileCoinClient(accountKey, Uri.parse(fogUrl),
                Uri.parse(consensusUrl));

        final int hashCode = mobileCoinClient.hashCode();
        ObjectStorage.addObject(hashCode, mobileCoinClient);
        return hashCode;
    }

    @Nullable
    public static BigInteger getBalance(int mobileClientId)
            throws InvalidFogResponse, NetworkException, AttestationException {
        MobileCoinClient mobileCoinClient = (MobileCoinClient) ObjectStorage.objectForKey(mobileClientId);
        return mobileCoinClient.getBalance().getAmountPicoMob();
    }

    @Nullable
    public static String getAccountActivity(int mobileClientId)
            throws NetworkException, InvalidFogResponse, AttestationException, JSONException {
        MobileCoinClient mobileCoinClient = (MobileCoinClient) ObjectStorage.objectForKey(mobileClientId);
        AccountSnapshot snapshot = mobileCoinClient.getAccountSnapshot();
        JSONObject result = new JSONObject();
        String balance = snapshot.getBalance().getAmountPicoMob().toString();
        AccountActivity activity = snapshot.getAccountActivity();
        result.put("balance", balance);
        result.put("blockCount", activity.getBlockCount());
        Set<OwnedTxOut> ownedTxOuts = activity.getAllTxOuts();
        JSONArray txOuts = new JSONArray();
        for (OwnedTxOut txOut : ownedTxOuts) {
            JSONObject jsonTxOut = new JSONObject();
            jsonTxOut.put("value", txOut.getValue().toString());
            jsonTxOut.put("receivedDate", formatDate(txOut.getReceivedBlockTimestamp()));
            jsonTxOut.put("receivedBlock", txOut.getReceivedBlockIndex().toString());
            jsonTxOut.put("keyImage", Base64.encodeToString(txOut.getKeyImage().getData(), Base64.NO_WRAP));
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
        return new SimpleDateFormat("MM/dd/yyyy KK:mm:ss a Z").format(date);
    }

    public static void setAuthorization(int mobileClientId, @NonNull String username, @NonNull String password) {
        MobileCoinClient mobileCoinClient = (MobileCoinClient) ObjectStorage.objectForKey(mobileClientId);
        mobileCoinClient.setFogBasicAuthorization(username, password);
    }

    public static int sendFunds(int mobileClientId, int recipientId, @NonNull PicoMob fee, @NonNull PicoMob amount)
            throws InvalidTransactionException, InsufficientFundsException, AttestationException, InvalidFogResponse,
            FragmentedAccountException, FeeRejectedException, InterruptedException, NetworkException,
            TransactionBuilderException, FogReportException {
        PublicAddress recipient = (PublicAddress) ObjectStorage.objectForKey(recipientId);
        MobileCoinClient mobileCoinClient = (MobileCoinClient) ObjectStorage.objectForKey(mobileClientId);

        final PendingTransaction pending = mobileCoinClient.prepareTransaction(recipient, amount.getPicoCountAsBigInt(),
                fee.getPicoCountAsBigInt());
        mobileCoinClient.submitTransaction(pending.getTransaction());

        Transaction.Status status;
        do {
            Thread.sleep(1000);
            status = mobileCoinClient.getTransactionStatus(pending.getTransaction());
        } while (status == Transaction.Status.UNKNOWN);

        Receipt receipt = pending.getReceipt();
        final int receiptId = receipt.hashCode();
        ObjectStorage.addObject(receiptId, receipt);

        return receiptId;
    }
}
