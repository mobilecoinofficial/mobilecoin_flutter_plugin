package com.mobilecoin.mobilecoin_flutter;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.annotation.VisibleForTesting;

import com.mobilecoin.lib.TokenId;
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
import java.util.Arrays;
import java.util.HashMap;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import mistyswap.AttestedMistySwapClient;

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
    private final ExecutorService executorService =
            Executors.newFixedThreadPool(EXECUTOR_THREAD_POOL_SIZE);

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
        channel =
                new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "mobilecoin_flutter");
        channel.setMethodCallHandler(this);
    }

    @Override
    public void onMethodCall(@NonNull final MethodCall call, @NonNull final Result result) {
        // Do all message handling on background thread because all messages
        // require long-running work, which would otherwise block Flutter's
        // platform thread.
        executorService.submit(() -> {
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
        });
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        channel.setMethodCallHandler(null);
    }

    /**
     * Interprets an incoming plugin channel message and then invokes the appropriate
     * <code>MobileCoinFlutterPluginChannelApi</code>.
     * <p>
     * The dispatching of channel messages is handled by a dedicated object so that we can test this
     * object without worrying about threading concerns. The channel's <code>onMethodCall</code>
     * method includes a <code>post()</code> to a background thread to do work, followed by another
     * <code>post()</code> to get back to Flutter's platform thread to send the response.
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
                    return api.createMobileCoinClient(getCallArgument(call, "accountKey"),
                            getCallArgument(call, "fogUrl"),
                            getCallArgument(call, "consensusUrl"),
                            call.argument("mistyswapUrl"), // can be null
                            getCallArgument(call, "useTestNet"),
                            getCallArgument(call, "clientConfigId"));
                case "MobileCoinClient#getAccountActivity":
                    return api.getAccountActivity(getCallArgument(call, "id"));

            case "MobileCoinClient#getBalance":
                return api.getBalance(getCallArgument(call, "id"));
            case "MobileCoinClient#setAuthorization":
                return api.setAuthorization(getCallArgument(call, "id"), getCallArgument(call, "username"),
                        getCallArgument(call, "password"));
            case "MobileCoinClient#createPendingTransaction": {
                String tokenIdString = getCallArgument(call, "tokenId");
                TokenId tokenId = TokenId.from(UnsignedLong.fromBigInteger(new BigInteger(tokenIdString)));
                return api.createPendingTransaction(getCallArgument(call, "id"), getCallArgument(call, "recipient"),
                        PicoMob.parsePico(getCallArgument(call, "fee")),
                        PicoMob.parsePico(getCallArgument(call, "amount")),
                        tokenId,
                        getCallArgument(call, "rngSeed"));
            }
            case "MobileCoinClient#sendFunds":
                return api.sendFunds(getCallArgument(call, "id"), getCallArgument(call, "transaction"));
            case "MobileCoinClient#checkTransactionStatus":
                return api.checkTransactionStatus(getCallArgument(call, "id"), getCallArgument(call, "receiptId"));
            case "AccountKey#fromBip39Entropy":
                return api.getAccountKeyFromBip39Entropy(getCallArgument(call, "bip39Entropy"),
                        call.argument("fogReportUri"), getCallArgument(call, "reportId"),
                        call.argument("fogAuthoritySpki"));

            case "MobileCoinClient#requiresDefragmentation": {
                BigInteger bigTokenId = new BigInteger((String) getCallArgument(call, "tokenId"));
                TokenId tokenId = TokenId.from(UnsignedLong.fromBigInteger(bigTokenId));
                return api.accountRequiresDefragmentation(
                    getCallArgument(call, "id"),
                    new BigInteger((String)getCallArgument(call, "amount")),
                    tokenId
                );
            }
            case "MobileCoinClient#defragmentAccount": {
                BigInteger bigTokenId = new BigInteger((String) getCallArgument(call, "tokenId"));
                TokenId tokenId = TokenId.from(UnsignedLong.fromBigInteger(bigTokenId));
                api.defragmentAccount(
                    getCallArgument(call, "id"),
                    new BigInteger((String)getCallArgument(call, "amount")),
                    tokenId,
                    getCallArgument(call, "shouldWriteRTHMemos"),
                    getCallArgument(call, "rngSeed")
                );
                return null;
            }
            case "MobileCoinClient#estimateTotalFee": {
                BigInteger bigTokenId = new BigInteger((String) getCallArgument(call, "tokenId"));
                TokenId tokenId = TokenId.from(UnsignedLong.fromBigInteger(bigTokenId));
                return api.estimateTotalFee(
                    getCallArgument(call, "id"),
                    new BigInteger((String)getCallArgument(call, "amount")),
                    tokenId
                );
            }
            case "MobileCoinClient#getTransferableAmount": {
                BigInteger bigTokenId = new BigInteger((String) getCallArgument(call, "tokenId"));
                TokenId tokenId = TokenId.from(UnsignedLong.fromBigInteger(bigTokenId));
                return api.getTransferableAmount(
                    getCallArgument(call, "id"),
                    tokenId
                );
            }
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
            case "PublicAddress#getAddressHash":
                return api.publicAddressGetAddressHash(getCallArgument(call, "id"));
            case "TransferPayload#getBip39Entropy":
                return api.transferPayloadGetBip39Entropy(getCallArgument(call, "id"));
            case "TransferPayload#getMemo":
                return api.transferPayloadGetMemo(getCallArgument(call, "id"));
            case "TransferPayload#getPublicKey":
                return api.transferPayloadGetPublicKey(getCallArgument(call, "id"));
            case "PaymentRequest#create": {
                BigInteger bigTokenId = new BigInteger((String) getCallArgument(call, "tokenId"));
                TokenId tokenId = TokenId.from(UnsignedLong.fromBigInteger(bigTokenId));
                return api.paymentRequestCreate(getCallArgument(call, "publicAddressId"),
                        getCallArgument(call, "amount"), getCallArgument(call, "memo"), tokenId);
            }
            case "PaymentRequest#getMemo":
                return api.paymentRequestGetMemo(getCallArgument(call, "id"));
            case "PaymentRequest#getPublicAddress":
                return api.paymentRequestGetPublicAddress(getCallArgument(call, "id"));
            case "PaymentRequest#getTokenId":
                return api.paymentRequestGetTokenId(getCallArgument(call, "id"));
            case "PaymentRequest#getValue":
                return api.paymentRequestGetValue(getCallArgument(call, "id"));
            case "Mnemonic#fromBip39Entropy":
                return api.mnemonicFromBip39Entropy(getCallArgument(call, "bip39Entropy"));
            case "Mnemonic#toBip39Entropy":
                return api.mnemonicToBip39Entropy(getCallArgument(call, "mnemonicPhrase"));
            case "Mnemonic#allWords":
                return api.mnemonicAllWords();
            case "CryptoBox#encrypt":
                return api.cryptoBoxEncrypt(getCallArgument(call, "data"),
                        getCallArgument(call, "publicKeyId"));
            case "CryptoBox#decrypt":
                return api.cryptoBoxDecrypt(getCallArgument(call, "data"),
                        getCallArgument(call, "privateKeyId"));
            case "ClientConfig#create":
                return api.clientConfigCreate();
            case "ClientConfig#addServiceConfig":
                String hardeningAdvisories = getCallArgument(call, "hardeningAdvisories");
                api.clientConfigAddServiceConfig(getCallArgument(call, "clientConfigId"),
                        getCallArgument(call, "fogViewMrEnclave"),
                        getCallArgument(call, "fogLedgerMrEnclave"),
                        getCallArgument(call, "fogReportMrEnclave"),
                        getCallArgument(call, "consensusMrEnclave"),
                        hardeningAdvisories.split(",", 0));
                return "";
            case "RistrettoPublic#fromBytes":
                return api.ristrettoPublicFromBytes(getCallArgument(call, "serializedBytes"));
            case "RistrettoPublic#toByteArray":
                return api.ristrettoPublicToByteArray(getCallArgument(call, "id"));
            case "RistrettoPrivate#fromBytes":
                return api.ristrettoPrivateFromBytes(getCallArgument(call, "serializedBytes"));
            case "RistrettoPrivate#toByteArray":
                return api.ristrettoPrivateToByteArray(getCallArgument(call, "id"));
            case "OnetimeKeys#createTxOutPublicKey":
                return api.createTxOutPublicKey(getCallArgument(call, "txOutPrivateKeyId"), getCallArgument(call, "recipientSpendPublicKeyId"));
            case "AttestedMistySwapClient#initiateOfframp":
                return api.attestedMistySwapClientInitiateOfframp(
                    getCallArgument(call, "mobileCoinClientId"),
                    getCallArgument(call, "initiateOfframpRequestBytes"));
            case "AttestedMistySwapClient#forgetOfframpRequestId":
                return api.attestedMistySwapClientForgetOfframp(
                    getCallArgument(call, "mobileCoinClientId"),
                    getCallArgument(call, "forgetOfframpRequestBytes"));
            case "AttestedMistySwapClient#getOfframpStatus":
                return api.attestedMistySwapClientGetOfframpStatus(
                    getCallArgument(call, "mobileCoinClientId"),
                    getCallArgument(call, "getOfframpStatusRequestBytes"));
            case "AttestedMistySwapClient#getOfframpDebugStatus":
                return api.attestedMistySwapClientGetOfframpDebugInfo(
                    getCallArgument(call, "mobileCoinClientId"),
                    getCallArgument(call, "getOfframpDebugInfoRequestBytes"));
            case "AttestedMistySwapClient#setupOnramp":
                return api.attestedMistySwapClientSetupOnramp(
                    getCallArgument(call, "mobileCoinClientId"),
                    getCallArgument(call, "setupOnrampRequestBytes"));
            case "AttestedMistySwapClient#forgetOnramp":
                return api.attestedMistySwapClientForgetOnramp(
                    getCallArgument(call, "mobileCoinClientId"),
                    getCallArgument(call, "forgetOnrampRequestBytes"));
            case "AttestedMistySwapClient#getOnrampStatus":
                return api.attestedMistySwapClientGetOnrampStatus(
                    getCallArgument(call, "mobileCoinClientId"),
                    getCallArgument(call, "getOnrampStatusRequestBytes"));
            case "AttestedMistySwapClient#getOnrampDebugInfo":
                return api.attestedMistySwapClientGetOnrampDebugInfo(
                    getCallArgument(call, "mobileCoinClientId"),
                    getCallArgument(call, "getOnrampDebugInfoRequestBytes"));
            case "AttestedMistySwapClient#getInfo":
                return api.attestedMistySwapClientGetInfo(
                    getCallArgument(call, "mobileCoinClientId"));
            default:
                throw new UnsupportedOperationException();
            }
        }
    }

    interface MobileCoinFlutterPluginChannelApi {
        /**
         * Creates a new <code>FftMobileCoinClient</code> and returns the hashCode of the new
         * instance.
         */
        Integer createMobileCoinClient(Integer accountKey, String fogUrl, String consensusUrl,
                @Nullable String mistySwapUrl, boolean useTestNet, Integer clientConfigId) throws InvalidUriException, AttestationException;

        /**
         * Retrieves and returns the current balance of all coins of the given
         * <code>FftMobileCoinClient</code>. The returned result is JSON encoded in format {tokenId:
         * balance}
         */
        String getBalance(Integer mobileCoinClientId) throws InvalidFogResponse, NetworkException,
                AttestationException, FogSyncException, JSONException;

        String getAccountActivity(Integer mobileCoinClientId)
                throws InvalidFogResponse, NetworkException, AttestationException, JSONException,
                FogSyncException, TransactionBuilderException;

        /**
         * Set the basic HTTP authorization username and password for future requests
         */
        Void setAuthorization(int mobileClientId, @NonNull String username,
                @NonNull String password);

        /**
         * Creates a PendingTransaction object from the given <code>FftMobileCoinClient</code> to
         * the given <code>recipient</code> and then returns pending transaction ID, along with the
         * payloadPublicKey, changePublicKey, payloadSharedSecret, and changeSharedSecret
         */
        HashMap<String, Object> createPendingTransaction(int mobileClientId, int recipientId,
                @NonNull PicoMob fee, @NonNull PicoMob amount, @NonNull TokenId tokenId,
                @NonNull byte[] rngSeed)
                throws InvalidFogResponse, InterruptedException, InvalidTransactionException,
                AttestationException, FeeRejectedException, InsufficientFundsException,
                FragmentedAccountException, NetworkException, TransactionBuilderException,
                FogReportException, FogSyncException, SerializationException;

        /**
         * Sends from the given <code>FftMobileCoinClient</code> based on the
         * <code>pendingTransactionId</code> and then returns the receipt ID.
         */
        String sendFunds(int mobileClientId, byte[] serializedTransaction)
                throws SerializationException, JSONException;

        /**
         * Checks to see if a transaction has gone through, given a transactionId returns an integer
         * representing the results.
         */
        Integer checkTransactionStatus(int mobileClientId, int receiptId)
                throws AttestationException, InvalidFogResponse, NetworkException, FogSyncException;

        /**
         *
         */
        int getAccountKeyFromBip39Entropy(byte[] bip39Entropy, String fogReportUri, String reportId,
                byte[] fogAuthoritySpki) throws InvalidUriException, BadEntropyException;

        /**
         * Retrieves the public address for the given <code>AccountKey</code>, stores the address is
         * local object storage, and returns its hash code.
         */
        int getAccountKeyPublicAddress(int publicAddressId);

        /**
         * Creates a <code>PrintableWrapper</code> from the given <code>b58String</code>, stores it
         * in local object storage, and returns its hash code.
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
         * <code>PrintableWrapper</code>, stores the public address in local object storage, and
         * returns its hash code.
         */
        int printableWrapperGetPublicAddress(int printableWrapperId);

        /**
         * Returns the <code>PrintableWrapper</code> associated with the given
         * <code>publicAddressId</code>.
         */
        int printableWrapperFromPublicAddress(int publicAddressId) throws SerializationException;

        /**
         * Returns true if the given <code>PrintableWrapper</code> has a transfer payload.
         */
        boolean printableWrapperHasTransferPayload(int printableWrapperId);

        /**
         * Retrieves the <code>TransferPayload</code> associated with the given
         * <code>PrintableWrapper</code>, stores the transfer payload in local object storage, and
         * returns its hash code.
         */
        int printableWrapperGetTransferPayload(int printableWrapperId);

        /**
         * Returns the <code>PrintableWrapper</code> associated with the given
         * <code>paymentRequestId</code>.
         */
        int printableWrapperFromPaymentRequest(int paymentRequestId) throws SerializationException;

        /**
         * Returns true if the given <code>PrintableWrapper</code> has a paymentRequest payload.
         */
        boolean printableWrapperHasPaymentRequest(int printableWrapperId);

        /**
         * Retrieves the <code>PaymentRequest</code> associated with the given
         * <code>PrintableWrapper</code>, stores the payment request in local object storage, and
         * returns its hash code.
         */
        int printableWrapperGetPaymentRequest(int printableWrapperId);

        /**
         * Returns the <code>PrintableWrapper</code> associated with the given
         * <code>transferPayloadId</code>.
         */
        int printableWrapperFromTransferPayload(int transferPayloadId)
                throws SerializationException;

        /**
         * Deserializes the given <code>byte[]</code> into a <code>PublicAddress</code>, stores the
         * address in local object storage, and returns its hash code.
         */
        int publicAddressFromBytes(byte[] publicAddress) throws Exception;

        /**
         * Looks up the given <code>PublicAddress</code> in local object storage, then returns a
         * serialized version as a <code>byte[]</code>.
         */
        byte[] publicAddressToByteArray(int publicAddressId);

        /**
         * Looks up the given <code>PublicAddress</code> in local object storage, then returns an
         * address hash.
         */
        byte[] publicAddressGetAddressHash(int publicAddressId);

        /**
         * Looks up the given <code>TransferPayload</code> in local object storage, then returns its
         * root entropy as a <code>byte[]</code>.
         */
        byte[] transferPayloadGetBip39Entropy(int transferPayloadId);

        /**
         * Looks up the given <code>TransferPayload</code> in local object storage, then returns its
         * memo.
         */
        String transferPayloadGetMemo(int transferPayloadId);

        /**
         * Looks up the given <code>TransferPayload</code> in local object storage, retrieves its
         * public key, stores the public key in local object storage, and then returns the public
         * key's hash code.
         */
        int transferPayloadGetPublicKey(int transferPayloadId);

        /**
         * Creates a new <code>PaymentRequest</code> in local object storage, then returns its id.
         */
        int paymentRequestCreate(int publicAddressId, @Nullable String amount,
                @Nullable String memo, @NonNull TokenId tokenId);

        /**
         * Looks up the given <code>PaymentRequest</code> in local object storage, then returns its
         * amount value as a <code>String</code>.
         */
        String paymentRequestGetValue(int paymentRequestId);

        /**
         * Looks up the given <code>PaymentRequest</code> in local object storage, then returns its
         * memo.
         */
        String paymentRequestGetMemo(int paymentRequestId);

        /**
         * Looks up the given <code>PaymentRequest</code> in local object storage, then returns its
         * token id 64bit value represented as <code>String</code>.
         */
        String paymentRequestGetTokenId(int paymentRequestId);

        /**
         * Looks up the given <code>PaymentRequest</code> in local object storage, then retrieves
         * its public address, stores that public address in local object storage, and then returns
         * the public address' hash code.
         */
        int paymentRequestGetPublicAddress(int paymentRequestId);

        /**
         * Convert the given b39 entropy into the mnemonic phrase The mnemonic phrase is a string of
         * 24 words delimited by a space
         */
        String mnemonicFromBip39Entropy(byte[] entropy) throws BadEntropyException;

        /**
         * Convert mnemonic phrase into the b39 entropy The mnemonic phrase is a string of 24 words
         * delimited by a space
         */
        byte[] mnemonicToBip39Entropy(String mnemonicPhrase) throws BadMnemonicException;

        /**
         * Returns a list of all allowed words for mnemonic phrases as a <code>String</code>
         */
        String mnemonicAllWords() throws BadMnemonicException;

        int clientConfigCreate();

        void clientConfigAddServiceConfig(Integer clientConfigId, String fogViewMrEnclave,
                String fogLedgerMrEnclave, String forReportMrEnclave, String consensusMrEnclave,
                String[] hardeningAdvisories) throws AttestationException;

        /**
         * Encrypt data using recipient's public key
         * Note: only recipient's account key can decrypt it
         */
        byte[] cryptoBoxEncrypt(byte[] data, int publicAddressId) throws Exception;

        /**
         * Decrypt data using recipient's account key
         * Note: only recipient's account key can decrypt it
         */
        byte[] cryptoBoxDecrypt(byte[] data, int accountKeyId) throws Exception;
        /**
         * Returns whether or not MobileCoin client can send a specified amount
         * without account defragmentation
         */

        boolean accountRequiresDefragmentation(
            int mobileClientId,
            @NonNull BigInteger amount,
            @NonNull TokenId tokenId
        ) throws Exception;

        /** Defragments the user's account.
        * <p>
        * An account needs to be defragmented when an account balance consists
        * of multiple coins and there are no big enough coins to successfully
        * send the transaction.
        * If the account is too fragmented, it might be necessary to defragment
        * the account more than once. However, wallet fragmentation is a
        * rare occurrence since there is an internal mechanism to defragment
        * the account during other operations.
        * <p>
        * `shouldWriteRTHMemos` writes sender and destination memos for a defrag
        * transactions if true.
        */
        void defragmentAccount(
            int mobileClientId,
            @NonNull BigInteger amount,
            @NonNull TokenId tokenId,
            boolean shouldWriteRTHMemos,
            @Nullable byte[] rngSeed
        ) throws Exception;

        /**
        * Estimates the minimum fee required to send a transaction with the specified amount. The account
        * balance consists of multiple coins, if there are no big enough coins to successfully send the
        * transaction {@link FragmentedAccountException} will be thrown. The account needs to be
        * defragmented in order to send the specified amount. See {MobileCoinAccountClient#defragmentAccount}.
        *
        * @param amount amount to send
        */
        String estimateTotalFee(
            int mobileClientId,
            @NonNull BigInteger amount,
            @NonNull TokenId tokenId
        ) throws Exception;

        /**
        * Calculate the total transferable amount excluding all the required fees for such transfer.
        */
        String getTransferableAmount(
            int mobileClientId,
            @NonNull TokenId tokenId
        ) throws Exception;

        /**
         * Deserializes the given <code>byte[]</code> into a <code>RistrettoPublic</code>, stores the
         * address in local object storage, and returns its hash code.
         */
        int ristrettoPublicFromBytes(byte[] serializedBytes) throws Exception;

        /**
         * Looks up the given <code>RistrettoPublic</code> in local object storage, then returns a
         * serialized version as a <code>byte[]</code>.
         */
        byte[] ristrettoPublicToByteArray(int ristrettoPublicId);

        /**
         * Deserializes the given <code>byte[]</code> into a <code>RistrettoPrivate</code>, stores the
         * address in local object storage, and returns its hash code.
         */
        int ristrettoPrivateFromBytes(byte[] serializedBytes) throws Exception;

        /**
         * Looks up the given <code>RistrettoPrivate</code> in local object storage, then returns a
         * serialized version as a <code>byte[]</code>.
         */
        byte[] ristrettoPrivateToByteArray(int ristrettoPrivateId);

        /**
         * Creates the TxOut public key from the TxOut private key and the recipient spend public key
         */
        int createTxOutPublicKey(int txOutPrivateKeyId , int recipientSpendPublicKeyId) throws Exception;

        byte[] attestedMistySwapClientInitiateOfframp(int mobileCoinClientId, byte[] initiateOfframpRequestBytes) throws AttestationException, NetworkException;

        byte[] attestedMistySwapClientForgetOfframp(int mobileCoinClientId, byte[] forgetOfframpRequestBytes) throws AttestationException, NetworkException;

        byte[] attestedMistySwapClientGetOfframpStatus(int mobileCoinClientId, byte[] getOfframpStatusRequestBytes) throws AttestationException, NetworkException;

        byte[] attestedMistySwapClientGetOfframpDebugInfo(int mobileCoinClientId, byte[] getOfframpDebugInfoRequestBytes) throws AttestationException, NetworkException;

        byte[] attestedMistySwapClientSetupOnramp(int mobileCoinClientId, byte[] setupOnrampRequestBytes) throws AttestationException, NetworkException;

        byte[] attestedMistySwapClientForgetOnramp(int mobileCoinClientId, byte[] forgetOnrampRequestBytes) throws AttestationException, NetworkException;

        byte[] attestedMistySwapClientGetOnrampStatus(int mobileCoinClientId, byte[] getOnrampStatusRequestBytes) throws AttestationException, NetworkException;

        byte[] attestedMistySwapClientGetOnrampDebugInfo(int mobileCoinClientId, byte[] getOnrampDebugInfoRequestBytes) throws AttestationException, NetworkException;

        int attestedMistySwapClientGetInfo(int mobileCoinClientId) throws AttestationException, NetworkException;

    }

    static class DefaultMobileCoinFlutterPluginChannelApi
            implements MobileCoinFlutterPluginChannelApi {

        @Override
        public Integer createMobileCoinClient(Integer accountKey, String fogUrl,
                String consensusUrl, @Nullable String mistySwapUrl, boolean useTestNet, Integer clientConfigId)
                throws InvalidUriException, AttestationException {
            return FfiMobileCoinClient.create(accountKey, fogUrl, consensusUrl, mistySwapUrl, useTestNet,
                    clientConfigId);
        }

        @Override
        public String getBalance(Integer mobileCoinClientId) throws InvalidFogResponse,
                NetworkException, AttestationException, FogSyncException, JSONException {
            return FfiMobileCoinClient.getBalance(mobileCoinClientId);
        }

        @Override
        public String getAccountActivity(Integer mobileCoinClientId)
                throws InvalidFogResponse, NetworkException, AttestationException, JSONException,
                FogSyncException, TransactionBuilderException {
            return FfiMobileCoinClient.getAccountActivity(mobileCoinClientId);
        }

        @Override
        public Void setAuthorization(int mobileClientId, @NonNull String username,
                @NonNull String password) {
            FfiMobileCoinClient.setAuthorization(mobileClientId, username, password);
            return null;
        }

        @Override
        public HashMap<String, Object> createPendingTransaction(int mobileClientId, int recipientId,
                @NonNull PicoMob fee, @NonNull PicoMob amount, @NonNull TokenId tokenId,
                @NonNull byte[] rngSeed) throws InvalidFogResponse, AttestationException,
                FeeRejectedException, InsufficientFundsException, FragmentedAccountException,
                NetworkException, TransactionBuilderException, FogReportException, FogSyncException,
                SerializationException {
            return FfiMobileCoinClient.createPendingTransaction(mobileClientId, recipientId, fee,
                    amount, tokenId, rngSeed);
        }

        @Override
        public String sendFunds(int mobileClientId, byte[] serializedTransaction)
                throws SerializationException, JSONException {
            return FfiMobileCoinClient.sendFunds(mobileClientId, serializedTransaction);
        }

        @Override
        public Integer checkTransactionStatus(int mobileClientId, int receiptId)
                throws AttestationException, InvalidFogResponse, NetworkException,
                FogSyncException {
            return FfiMobileCoinClient.checkTransactionStatus(mobileClientId, receiptId);
        }

        @Override
        public int getAccountKeyFromBip39Entropy(byte[] entropy, String fogReportUri,
                String reportId, byte[] fogAuthoritySpki)
                throws InvalidUriException, BadEntropyException {
            return FfiAccountKey.fromBip39Entropy(entropy, fogReportUri, reportId,
                    fogAuthoritySpki);
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
        public String printableWrapperToB58String(int printableWrapperId)
                throws SerializationException {
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
        public int printableWrapperFromPublicAddress(int publicAddressId)
                throws SerializationException {
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
        public int printableWrapperFromPaymentRequest(int paymentRequestId)
                throws SerializationException {
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
        public int printableWrapperFromTransferPayload(int transferPayloadId)
                throws SerializationException {
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
        public byte[] publicAddressGetAddressHash(int publicAddressId) {
            return FfiPublicAddress.getAddressHash(publicAddressId);
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
        public int paymentRequestCreate(int publicAddressId, @Nullable String amount,
                @Nullable String memo, @NonNull TokenId tokenId) {
            UnsignedLong unsignedAmount =
                    amount == null ? null : UnsignedLong.fromBigInteger(new BigInteger(amount));
            return FfiPaymentRequest.create(publicAddressId, unsignedAmount, memo, tokenId);
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
        public String paymentRequestGetTokenId(int paymentRequestId) {
            return FfiPaymentRequest.getTokenId(paymentRequestId);
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

        @Override
        public int clientConfigCreate() {
            return FfiClientConfig.create();
        }

        @Override
        public void clientConfigAddServiceConfig(Integer clientConfigId, String fogViewMrEnclave,
                String fogLedgerMrEnclave, String forReportMrEnclave, String consensusMrEnclave,
                String[] hardeningAdvisories) throws AttestationException {
            FfiClientConfig.addServiceConfig(clientConfigId, fogViewMrEnclave, fogLedgerMrEnclave,
                    forReportMrEnclave, consensusMrEnclave, hardeningAdvisories);
        }

        @Override
        public byte[] cryptoBoxEncrypt(byte[] data, int publicAddressId) {
            return FfiCryptoBox.encrypt(data, publicAddressId);
        }

        @Override
        public byte[] cryptoBoxDecrypt(byte[] data, int accountKeyId) throws Exception {
            return FfiCryptoBox.decrypt(data, accountKeyId);
        }

        public boolean accountRequiresDefragmentation(
            int mobileClientId,
            @NonNull BigInteger amount,
            @NonNull TokenId tokenId
        ) throws Exception {
            return FfiMobileCoinClient.requiresDefragmentation(
                mobileClientId,
                amount,
                tokenId
            );
        }

        @Override
        public void defragmentAccount(int mobileClientId, @NonNull BigInteger amount,
        @NonNull TokenId tokenId, boolean shouldWriteRTHMemos,
        @Nullable byte[] rngSeed
        ) throws Exception {
            FfiMobileCoinClient.defragmentAccount(
                mobileClientId,
                amount,
                tokenId,
                shouldWriteRTHMemos,
                rngSeed
            );
        }

        @Override
        public String estimateTotalFee(
            int mobileClientId,
            @NonNull BigInteger amount,
            @NonNull TokenId tokenId
        ) throws Exception {
            return FfiMobileCoinClient.estimateTotalFee(
                mobileClientId,
                amount,
                tokenId
            );
        }

        @Override
        public String getTransferableAmount(
            int mobileClientId,
            @NonNull TokenId tokenId
        ) throws Exception {
            return FfiMobileCoinClient.getTransferableAmount(
                mobileClientId,
                tokenId
            );
        }

        @Override
        public int ristrettoPublicFromBytes(byte[] serializedBytes) throws Exception {
            return FfiRistrettoPublic.fromBytes(serializedBytes);
        }

        @Override
        public byte[] ristrettoPublicToByteArray(int ristrettoPublicId) {
            return FfiRistrettoPublic.toByteArray(ristrettoPublicId);
        }

        @Override
        public int ristrettoPrivateFromBytes(byte[] serializedBytes) throws Exception {
            return FfiRistrettoPrivate.fromBytes(serializedBytes);
        }

        @Override
        public byte[] ristrettoPrivateToByteArray(int ristrettoPrivateId) {
            return FfiRistrettoPrivate.toByteArray(ristrettoPrivateId);
        }

        @Override
        public int createTxOutPublicKey(int txOutPrivateKeyId, int recipientSpendPublicKeyId) {
            return FfiOnetimeKeys.createTxOutPublicKey(txOutPrivateKeyId, recipientSpendPublicKeyId);
        }

        @Override
        public byte[] attestedMistySwapClientInitiateOfframp(int mobileCoinClientId, byte[] initiateOfframpRequestBytes) throws AttestationException, NetworkException {
            final int mistySwapClientHash = FfiMobileCoinClient.mistySwapClientHashCode(mobileCoinClientId);
            final AttestedMistySwapClient mistySwapClient =
                    (AttestedMistySwapClient)ObjectStorage.objectForKey(mistySwapClientHash);
            return mistySwapClient.initiateOfframp(initiateOfframpRequestBytes);
        }

        @Override
        public byte[] attestedMistySwapClientForgetOfframp(int mobileCoinClientId, byte[] forgetOfframpRequestBytes) throws AttestationException, NetworkException {
            final int mistySwapClientHash = FfiMobileCoinClient.mistySwapClientHashCode(mobileCoinClientId);
            final AttestedMistySwapClient mistySwapClient =
                    (AttestedMistySwapClient)ObjectStorage.objectForKey(mistySwapClientHash);
            return mistySwapClient.forgetOfframp(forgetOfframpRequestBytes);
        }

        @Override
        public byte[] attestedMistySwapClientGetOfframpStatus(int mobileCoinClientId, byte[] getOfframpStatusRequestBytes) throws AttestationException, NetworkException {
            final int mistySwapClientHash = FfiMobileCoinClient.mistySwapClientHashCode(mobileCoinClientId);
            final AttestedMistySwapClient mistySwapClient =
                    (AttestedMistySwapClient)ObjectStorage.objectForKey(mistySwapClientHash);
            return mistySwapClient.getOfframpStatus(getOfframpStatusRequestBytes);
        }

        @Override
        public byte[] attestedMistySwapClientGetOfframpDebugInfo(int mobileCoinClientId, byte[] getOfframpDebugInfoRequestBytes) throws AttestationException, NetworkException {
            final int mistySwapClientHash = FfiMobileCoinClient.mistySwapClientHashCode(mobileCoinClientId);
            final AttestedMistySwapClient mistySwapClient =
                    (AttestedMistySwapClient)ObjectStorage.objectForKey(mistySwapClientHash);
            return mistySwapClient.getOfframpDebugInfo(getOfframpDebugInfoRequestBytes);
        }

        @Override
        public byte[] attestedMistySwapClientSetupOnramp(int mobileCoinClientId, byte[] setupOnrampRequestBytes) throws AttestationException, NetworkException {
            final int mistySwapClientHash = FfiMobileCoinClient.mistySwapClientHashCode(mobileCoinClientId);
            final AttestedMistySwapClient mistySwapClient =
                    (AttestedMistySwapClient)ObjectStorage.objectForKey(mistySwapClientHash);
            return mistySwapClient.setupOnramp(setupOnrampRequestBytes);
        }

        @Override
        public byte[] attestedMistySwapClientForgetOnramp(int mobileCoinClientId, byte[] forgetOnrampRequestBytes) throws AttestationException, NetworkException {
            final int mistySwapClientHash = FfiMobileCoinClient.mistySwapClientHashCode(mobileCoinClientId);
            final AttestedMistySwapClient mistySwapClient =
                    (AttestedMistySwapClient)ObjectStorage.objectForKey(mistySwapClientHash);
            return mistySwapClient.forgetOnramp(forgetOnrampRequestBytes);
        }

        @Override
        public byte[] attestedMistySwapClientGetOnrampStatus(int mobileCoinClientId, byte[] getOnrampStatusRequestBytes) throws AttestationException, NetworkException {
            final int mistySwapClientHash = FfiMobileCoinClient.mistySwapClientHashCode(mobileCoinClientId);
            final AttestedMistySwapClient mistySwapClient =
                    (AttestedMistySwapClient)ObjectStorage.objectForKey(mistySwapClientHash);
            return mistySwapClient.getOnrampStatus(getOnrampStatusRequestBytes);
        }

        @Override
        public byte[] attestedMistySwapClientGetOnrampDebugInfo(int mobileCoinClientId, byte[] getOnrampDebugInfoRequestBytes) throws AttestationException, NetworkException {
            final int mistySwapClientHash = FfiMobileCoinClient.mistySwapClientHashCode(mobileCoinClientId);
            final AttestedMistySwapClient mistySwapClient =
                    (AttestedMistySwapClient)ObjectStorage.objectForKey(mistySwapClientHash);
            return mistySwapClient.getOnrampDebugInfo(getOnrampDebugInfoRequestBytes);
        }

        @Override
        public int attestedMistySwapClientGetInfo(int mobileCoinClientId) throws AttestationException, NetworkException {
            final int mistySwapClientHash = FfiMobileCoinClient.mistySwapClientHashCode(mobileCoinClientId);
            final AttestedMistySwapClient mistySwapClient =
                    (AttestedMistySwapClient)ObjectStorage.objectForKey(mistySwapClientHash);
            final byte[] getInfoResponseBytes = mistySwapClient.getInfo();
            final int hashCode = Arrays.hashCode(getInfoResponseBytes);
            ObjectStorage.addObject(hashCode, getInfoResponseBytes);
            return hashCode;
        }

    }

}
