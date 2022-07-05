package com.mobilecoin.mobilecoin_flutter;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.annotation.VisibleForTesting;

import com.mobilecoin.lib.UnsignedLong;
import com.mobilecoin.lib.exceptions.AttestationException;
import com.mobilecoin.lib.exceptions.BadEntropyException;
import com.mobilecoin.lib.exceptions.BadMnemonicException;
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

import org.json.JSONException;

import java.math.BigInteger;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

/**
 * MobileCoinFlutterPlugin
 */
public class MobileCoinFlutterPlugin implements FlutterPlugin, MethodCallHandler {
    private static final int EXECUTOR_THREAD_POOL_SIZE = 4;
    /// The MethodChannel that will the communication between Flutter and native
    /// Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine
    /// and unregister it
    /// when the Flutter Engine is detached from the Activity
    private MethodChannel channel;
    private final ExecutorService executorService = Executors.newFixedThreadPool(EXECUTOR_THREAD_POOL_SIZE);

    private final ChannelMessageDispatcher dispatcher;

    // Needed for code generation in the app's plugin registrant.
    public MobileCoinFlutterPlugin() {
        this(new DefaultMobileCoinFlutterPluginChannelApi());
    }

    @VisibleForTesting
    MobileCoinFlutterPlugin(MobileCoinFlutterPluginChannelApi api) {
        dispatcher = new ChannelMessageDispatcher(api);
    }

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "mobilecoin_flutter");
        channel.setMethodCallHandler(this);
    }

    @Override
    public void onMethodCall(@NonNull final MethodCall call, @NonNull final Result result) {
        // Do all message handling on background thread because all messages
        // require long-running work, which would otherwise block Flutter's
        // platform thread.
        executorService.submit(new Runnable() {
            public void run() {
                // WIP: eventually the dispatcher will support all messages,
                // but for now it only handles some of them, so we try
                // the dispatcher first and then fallback to reflection
                // handling.
                try {
                    Object resultValue = dispatcher.onMethodCall(call);
                    Ffi.processSuccess(result, resultValue);
                } catch (Exception exception) {
                    exception.printStackTrace();
                    Ffi.processError(result, exception.getLocalizedMessage(), exception);
                }
            }
        });
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        channel.setMethodCallHandler(null);
    }

    /**
     * Interprets an incoming plugin channel message and then invokes the
     * appropriate <code>MobileCoinFlutterPluginChannelApi</code>.
     *
     * The dispatching of channel messages is handled by a dedicated object so that
     * we can test this object without worrying about threading concerns. The
     * channel's <code>onMethodCall</code> method includes a <code>post()</code> to
     * a background thread to do work, followed by another <code>post()</code> to
     * get back to Flutter's platform thread to send the response.
     */
    static class ChannelMessageDispatcher {
        private final MobileCoinFlutterPluginChannelApi api;

        ChannelMessageDispatcher(MobileCoinFlutterPluginChannelApi api) {
            this.api = api;
        }

        @NonNull
        private <T> T getCallArgument(@NonNull MethodCall call, @NonNull String key) {
            T argument = call.argument(key);
            if (null == argument) {
                throw new IllegalArgumentException();
            }
            return argument;
        }

        public Object onMethodCall(@NonNull final MethodCall call) throws Exception {
            String message = call.method;
            switch (message) {
            case "MobileCoinClient#create":
                return api.createMobileCoinClient(getCallArgument(call, "accountKey"), getCallArgument(call, "fogUrl"),
                        getCallArgument(call, "consensusUrl"), getCallArgument(call, "useTestNet"));
            case "MobileCoinClient#getAccountActivity":
                return api.getAccountActivity(getCallArgument(call, "id"));

            case "MobileCoinClient#getBalance":
                BigInteger balance = api.getBalance(getCallArgument(call, "id"));
                return balance.toString();
            case "MobileCoinClient#setAuthorization":
                return api.setAuthorization(getCallArgument(call, "id"), getCallArgument(call, "username"),
                        getCallArgument(call, "password"));
            case "MobileCoinClient#createPendingTransaction":
                return api.createPendingTransaction(getCallArgument(call, "id"), getCallArgument(call, "recipient"),
                        PicoMob.parsePico(getCallArgument(call, "fee")),
                        PicoMob.parsePico(getCallArgument(call, "amount")));
            case "MobileCoinClient#sendFunds":
                return api.sendFunds(getCallArgument(call, "id"), getCallArgument(call, "pendingTransactionId"));
            case "MobileCoinClient#checkTransactionStatus":
                return api.checkTransactionStatus(getCallArgument(call, "id"), getCallArgument(call, "transactionId"));
            case "AccountKey#fromBip39Entropy":
                return api.getAccountKeyFromBip39Entropy(getCallArgument(call, "bip39Entropy"),
                        call.argument("fogReportUri"), getCallArgument(call, "reportId"),
                        call.argument("fogAuthoritySpki"));
            case "AccountKey#getPublicAddress":
                return api.getAccountKeyPublicAddress(getCallArgument(call, "id"));
            case "PrintableWrapper#fromB58String":
                return api.printableWrapperFromB58String(getCallArgument(call, "b58String"));
            case "PrintableWrapper#toB58String":
                return api.printableWrapperToB58String(getCallArgument(call, "id"));
            case "PrintableWrapper#hasPublicAddress":
                return api.printableWrapperHasPublicAddress(getCallArgument(call, "id"));
            case "PrintableWrapper#getPublicAddress":
                return api.printableWrapperGetPublicAddress(getCallArgument(call, "id"));
            case "PrintableWrapper#fromPublicAddress":
                return api.printableWrapperFromPublicAddress(getCallArgument(call, "id"));
            case "PrintableWrapper#fromPaymentRequest":
                return api.printableWrapperFromPaymentRequest(getCallArgument(call, "id"));
            case "PrintableWrapper#hasTransferPayload":
                return api.printableWrapperHasTransferPayload(getCallArgument(call, "id"));
            case "PrintableWrapper#getTransferPayload":
                return api.printableWrapperGetTransferPayload(getCallArgument(call, "id"));
            case "PrintableWrapper#hasPaymentRequest":
                return api.printableWrapperHasPaymentRequest(getCallArgument(call, "id"));
            case "PrintableWrapper#getPaymentRequest":
                return api.printableWrapperGetPaymentRequest(getCallArgument(call, "id"));
            case "PrintableWrapper#fromTransferPayload":
                return api.printableWrapperFromTransferPayload(getCallArgument(call, "id"));
            case "PublicAddress#fromBytes":
                return api.publicAddressFromBytes(getCallArgument(call, "serializedBytes"));
            case "PublicAddress#toByteArray":
                return api.publicAddressToByteArray(getCallArgument(call, "id"));
            case "TransferPayload#getBip39Entropy":
                return api.transferPayloadGetBip39Entropy(getCallArgument(call, "id"));
            case "TransferPayload#getMemo":
                return api.transferPayloadGetMemo(getCallArgument(call, "id"));
            case "TransferPayload#getPublicKey":
                return api.transferPayloadGetPublicKey(getCallArgument(call, "id"));
            case "PaymentRequest#create":
                return api.paymentRequestCreate(getCallArgument(call, "publicAddressId"),
                        getCallArgument(call, "amount"), getCallArgument(call, "memo"));
            case "PaymentRequest#getMemo":
                return api.paymentRequestGetMemo(getCallArgument(call, "id"));
            case "PaymentRequest#getPublicAddress":
                return api.paymentRequestGetPublicAddress(getCallArgument(call, "id"));
            case "PaymentRequest#getValue":
                return api.paymentRequestGetValue(getCallArgument(call, "id"));
            case "Mnemonic#fromBip39Entropy":
                return api.mnemonicFromBip39Entropy(getCallArgument(call, "bip39Entropy"));
            case "Mnemonic#toBip39Entropy":
                return api.mnemonicToBip39Entropy(getCallArgument(call, "mnemonicPhrase"));
            case "Mnemonic#allWords":
                return api.mnemonicAllWords();
            default:
                throw new UnsupportedOperationException();
            }
        }
    }

    interface MobileCoinFlutterPluginChannelApi {
        /**
         * Creates a new <code>FftMobileCoinClient</code> and returns the hashCode of
         * the new instance.
         */
        Integer createMobileCoinClient(Integer accountKey, String fogUrl, String consensusUrl, boolean useTestNet)
                throws InvalidUriException;

        /**
         * Retrieves and returns the current balance of the given
         * <code>FftMobileCoinClient</code>.
         */
        BigInteger getBalance(Integer mobileCoinClientId)
                throws InvalidFogResponse, NetworkException, AttestationException, FogSyncException;

        String getAccountActivity(Integer mobileCoinClientId)
                throws InvalidFogResponse, NetworkException, AttestationException, JSONException, FogSyncException, TransactionBuilderException;

        /**
         * Set the basic HTTP authorization username and password for future requests
         */
        Void setAuthorization(int mobileClientId, @NonNull String username, @NonNull String password);

        /**
         * Creates a PendingTransaction object from the given <code>FftMobileCoinClient</code> to
         * the given <code>recipient</code> and then returns pending transaction ID, along with
         * the payloadPublicKey, changePublicKey, payloadSharedSecret, and changeSharedSecret
         */
        String createPendingTransaction(int mobileClientId, int recipientId, @NonNull PicoMob fee, @NonNull PicoMob amount)
                throws InvalidFogResponse, InterruptedException, InvalidTransactionException, AttestationException,
                FeeRejectedException, InsufficientFundsException, FragmentedAccountException, NetworkException,
                TransactionBuilderException, FogReportException, JSONException, FogSyncException;

        /**
         * Sends from the given <code>FftMobileCoinClient</code> based on the
         * <code>pendingTransactionId</code> and then returns the receipt ID.
         */
        String sendFunds(int mobileClientId, int pendingTransactionId)
                throws InvalidFogResponse, InterruptedException, InvalidTransactionException, AttestationException,
                FeeRejectedException, InsufficientFundsException, FragmentedAccountException, NetworkException,
                TransactionBuilderException, FogReportException, JSONException, FogSyncException;

        /**
         * Checks to see if a transaction has gone through, given a transactionId
         * returns an integer representing the results.
         */
        Integer checkTransactionStatus(int mobileClientId, int transactionId)
                throws AttestationException, InvalidFogResponse, NetworkException, FogSyncException;

        /**
         *
         */
        int getAccountKeyFromBip39Entropy(byte[] bip39Entropy, String fogReportUri, String reportId,
                                          byte[] fogAuthoritySpki) throws InvalidUriException, BadEntropyException;

        /**
         * Retrieves the public address for the given <code>AccountKey</code>, stores
         * the address is local object storage, and returns its hash code.
         */
        int getAccountKeyPublicAddress(int publicAddressId);

        /**
         * Creates a <code>PrintableWrapper</code> from the given
         * <code>b58String</code>, stores it in local object storage, and returns its
         * hash code.
         */
        int printableWrapperFromB58String(String b58String) throws Exception;

        /**
         * Converts the <code>PrintableWrapper</code> associated with the given
         * <code>printableWrapperId</code> into a b58string and returns it.
         */
        String printableWrapperToB58String(int printableWrapperId) throws SerializationException;

        /**
         * Returns true if the given <code>PrintableWrapper</code> has a public address.
         */
        boolean printableWrapperHasPublicAddress(int printableWrapperId);

        /**
         * Retrieves the <code>PublicAddress</code> associated with the given
         * <code>PrintableWrapper</code>, stores the public address in local object
         * storage, and returns its hash code.
         */
        int printableWrapperGetPublicAddress(int printableWrapperId);

        /**
         * Returns the <code>PrintableWrapper</code> associated with the given
         * <code>publicAddressId</code>.
         */
        int printableWrapperFromPublicAddress(int publicAddressId) throws SerializationException;

        /**
         * Returns true if the given <code>PrintableWrapper</code> has a transfer
         * payload.
         */
        boolean printableWrapperHasTransferPayload(int printableWrapperId);

        /**
         * Retrieves the <code>TransferPayload</code> associated with the given
         * <code>PrintableWrapper</code>, stores the transfer payload in local object
         * storage, and returns its hash code.
         */
        int printableWrapperGetTransferPayload(int printableWrapperId);

        /**
         * Returns the <code>PrintableWrapper</code> associated with the given
         * <code>paymentRequestId</code>.
         */
        int printableWrapperFromPaymentRequest(int paymentRequestId) throws SerializationException;

        /**
         * Returns true if the given <code>PrintableWrapper</code> has a paymentRequest
         * payload.
         */
        boolean printableWrapperHasPaymentRequest(int printableWrapperId);

        /**
         * Retrieves the <code>PaymentRequest</code> associated with the given
         * <code>PrintableWrapper</code>, stores the payment request in local object
         * storage, and returns its hash code.
         */
        int printableWrapperGetPaymentRequest(int printableWrapperId);

        /**
         * Returns the <code>PrintableWrapper</code> associated with the given
         * <code>transferPayloadId</code>.
         */
        int printableWrapperFromTransferPayload(int transferPayloadId) throws SerializationException;

        /**
         * Deserializes the given <code>byte[]</code> into a <code>PublicAddress</code>,
         * stores the address in local object storage, and returns its hash code.
         */
        int publicAddressFromBytes(byte[] publicAddress) throws Exception;

        /**
         * Looks up the given <code>PublicAddress</code> in local object storage, then
         * returns a serialized version as a <code>byte[]</code>.
         */
        byte[] publicAddressToByteArray(int publicAddressId);

        /**
         * Looks up the given <code>TransferPayload</code> in local object storage, then
         * returns its root entropy as a <code>byte[]</code>.
         */
        byte[] transferPayloadGetBip39Entropy(int transferPayloadId);

        /**
         * Looks up the given <code>TransferPayload</code> in local object storage, then
         * returns its memo.
         */
        String transferPayloadGetMemo(int transferPayloadId);

        /**
         * Looks up the given <code>TransferPayload</code> in local object storage,
         * retrieves its public key, stores the public key in local object storage, and
         * then returns the public key's hash code.
         */
        int transferPayloadGetPublicKey(int transferPayloadId);

        /**
         * Creates a new <code>PaymentRequest</code> in local object storage, then
         * returns its id.
         */
        int paymentRequestCreate(int publicAddressId, @Nullable String amount, @Nullable String memo);

        /**
         * Looks up the given <code>PaymentRequest</code> in local object storage, then
         * returns its amount value as a <code>String</code>.
         */
        String paymentRequestGetValue(int paymentRequestId);

        /**
         * Looks up the given <code>PaymentRequest</code> in local object storage, then
         * returns its memo.
         */
        String paymentRequestGetMemo(int paymentRequestId);

        /**
         * Looks up the given <code>PaymentRequest</code> in local object storage, then
         * retrieves its public address, stores that public address in local object
         * storage, and then returns the public address' hash code.
         */
        int paymentRequestGetPublicAddress(int paymentRequestId);

        /**
         * Convert the given b39 entropy into the mnemonic phrase The mnemonic phrase is
         * a string of 24 words delimited by a space
         */
        String mnemonicFromBip39Entropy(byte[] entropy) throws BadEntropyException;

        /**
         * Convert mnemonic phrase into the b39 entropy The mnemonic phrase is a string
         * of 24 words delimited by a space
         */
        byte[] mnemonicToBip39Entropy(String mnemonicPhrase) throws BadMnemonicException;

        /**
         * Returns a list of all allowed words for mnemonic phrases as a
         * <code>String</code>
         */
        String mnemonicAllWords() throws BadMnemonicException;
    }

    static class DefaultMobileCoinFlutterPluginChannelApi implements MobileCoinFlutterPluginChannelApi {

        @Override
        public Integer createMobileCoinClient(Integer accountKey, String fogUrl, String consensusUrl,
                                              boolean useTestNet) throws InvalidUriException {
            return FfiMobileCoinClient.create(accountKey, fogUrl, consensusUrl, useTestNet);
        }

        @Override
        public BigInteger getBalance(Integer mobileCoinClientId)
                throws InvalidFogResponse, NetworkException, AttestationException, FogSyncException {
            return FfiMobileCoinClient.getBalance(mobileCoinClientId);
        }

        @Override
        public String getAccountActivity(Integer mobileCoinClientId)
                throws InvalidFogResponse, NetworkException, AttestationException, JSONException, FogSyncException, TransactionBuilderException {
            return FfiMobileCoinClient.getAccountActivity(mobileCoinClientId);
        }

        @Override
        public Void setAuthorization(int mobileClientId, @NonNull String username, @NonNull String password) {
            FfiMobileCoinClient.setAuthorization(mobileClientId, username, password);
            return null;
        }

        @Override
        public String createPendingTransaction(int mobileClientId, int recipientId, @NonNull PicoMob fee, @NonNull PicoMob amount)
                throws InvalidFogResponse, AttestationException, FeeRejectedException, InsufficientFundsException,
                FragmentedAccountException, NetworkException, TransactionBuilderException, FogReportException,
                JSONException, FogSyncException {
            return FfiMobileCoinClient.createPendingTransaction(mobileClientId, recipientId, fee, amount);
        }

        @Override
        public String sendFunds(int mobileClientId, int pendingTransactionId)
                throws InvalidTransactionException, AttestationException, NetworkException, JSONException {
            return FfiMobileCoinClient.sendFunds(mobileClientId, pendingTransactionId);
        }

        @Override
        public Integer checkTransactionStatus(int mobileClientId, int transactionId)
                throws AttestationException, InvalidFogResponse, NetworkException, FogSyncException {
            return FfiMobileCoinClient.checkTransactionStatus(mobileClientId, transactionId);
        }

        @Override
        public int getAccountKeyFromBip39Entropy(byte[] entropy, String fogReportUri, String reportId,
                                                 byte[] fogAuthoritySpki) throws InvalidUriException, BadEntropyException {
            return FfiAccountKey.fromBip39Entropy(entropy, fogReportUri, reportId, fogAuthoritySpki);
        }

        @Override
        public int getAccountKeyPublicAddress(int publicAddressId) {
            return FfiAccountKey.getPublicAddress(publicAddressId);
        }

        @Override
        public int printableWrapperFromB58String(String b58String) throws Exception {
            return FfiPrintableWrapper.fromB58String(b58String);
        }

        @Override
        public String printableWrapperToB58String(int printableWrapperId) throws SerializationException {
            return FfiPrintableWrapper.toB58String(printableWrapperId);
        }

        @Override
        public boolean printableWrapperHasPublicAddress(int printableWrapperId) {
            return FfiPrintableWrapper.hasPublicAddress(printableWrapperId);
        }

        @Override
        public int printableWrapperGetPublicAddress(int printableWrapperId) {
            return FfiPrintableWrapper.getPublicAddress(printableWrapperId);
        }

        @Override
        public int printableWrapperFromPublicAddress(int publicAddressId) throws SerializationException {
            return FfiPrintableWrapper.fromPublicAddress(publicAddressId);
        }

        @Override
        public boolean printableWrapperHasTransferPayload(int printableWrapperId) {
            return FfiPrintableWrapper.hasTransferPayload(printableWrapperId);
        }

        @Override
        public int printableWrapperGetTransferPayload(int printableWrapperId) {
            return FfiPrintableWrapper.getTransferPayload(printableWrapperId);
        }

        @Override
        public int printableWrapperFromPaymentRequest(int paymentRequestId) throws SerializationException {
            return FfiPrintableWrapper.fromPaymentRequest(paymentRequestId);
        }

        @Override
        public boolean printableWrapperHasPaymentRequest(int printableWrapperId) {
            return FfiPrintableWrapper.hasPaymentRequest(printableWrapperId);
        }

        @Override
        public int printableWrapperGetPaymentRequest(int printableWrapperId) {
            return FfiPrintableWrapper.getPaymentRequest(printableWrapperId);
        }

        @Override
        public int printableWrapperFromTransferPayload(int transferPayloadId) throws SerializationException {
            return FfiPrintableWrapper.fromTransferPayload(transferPayloadId);
        }

        @Override
        public int publicAddressFromBytes(byte[] publicAddress) throws Exception {
            return FfiPublicAddress.fromBytes(publicAddress);
        }

        @Override
        public byte[] publicAddressToByteArray(int publicAddressId) {
            return FfiPublicAddress.toByteArray(publicAddressId);
        }

        @Override
        public byte[] transferPayloadGetBip39Entropy(int transferPayloadId) {
            return FfiTransferPayload.getBip39Entropy(transferPayloadId);
        }

        @Override
        public String transferPayloadGetMemo(int transferPayloadId) {
            return FfiTransferPayload.getMemo(transferPayloadId);
        }

        @Override
        public int transferPayloadGetPublicKey(int transferPayloadId) {
            return FfiTransferPayload.getPublicKey(transferPayloadId);
        }

        @Override
        public int paymentRequestCreate(int publicAddressId, @Nullable String amount, @Nullable String memo) {
            UnsignedLong unsignedAmount = amount == null ? null : UnsignedLong.fromBigInteger(new BigInteger(amount));
            return FfiPaymentRequest.create(publicAddressId, unsignedAmount, memo);
        }

        @Override
        public String paymentRequestGetValue(int paymentRequestId) {
            return FfiPaymentRequest.getValue(paymentRequestId);
        }

        @Override
        public String paymentRequestGetMemo(int paymentRequestId) {
            return FfiPaymentRequest.getMemo(paymentRequestId);
        }

        @Override
        public int paymentRequestGetPublicAddress(int paymentRequestId) {
            return FfiPaymentRequest.getPublicAddress(paymentRequestId);
        }

        @Override
        public String mnemonicFromBip39Entropy(byte[] entropy) throws BadEntropyException {
            return FfiMnemonic.fromBip39Entropy(entropy);
        }

        @Override
        public byte[] mnemonicToBip39Entropy(String mnemonicPhrase) throws BadMnemonicException {
            return FfiMnemonic.toBip39Entropy(mnemonicPhrase);
        }

        @Override
        public String mnemonicAllWords() throws BadMnemonicException {
            return FfiMnemonic.allWords();
        }
    }
}
