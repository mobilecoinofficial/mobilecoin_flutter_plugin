// Copyright (c) 2021-2026 MobileCoin. All rights reserved.

package mistysign;

import androidx.annotation.Keep;
import androidx.annotation.NonNull;

import com.google.protobuf.AbstractMessageLite;
import com.google.protobuf.ByteString;
import com.google.protobuf.CodedOutputStream;
import com.google.protobuf.Parser;
import com.mobilecoin.lib.AttestedClient;
import com.mobilecoin.lib.ClientConfig;
import com.mobilecoin.lib.LoadBalancer;
import com.mobilecoin.lib.RandomLoadBalancer;
import com.mobilecoin.lib.TrustedIdentities;
import com.mobilecoin.lib.exceptions.AttestationException;
import com.mobilecoin.lib.exceptions.InvalidUriException;
import com.mobilecoin.lib.network.TransportProtocol;
import com.mobilecoin.lib.network.services.transport.Transport;

import java.io.IOException;
import java.io.OutputStream;

import attest.Attest;

/**
 * An attested channel to a Mistysign enclave whose transport the caller owns.
 * <p>
 * The counterpart of <code>MistysignAttestedSession</code> in MobileCoin-Swift,
 * exposing the same handshake and message operations. Unlike
 * {@link mistyswap.AttestedMistySwapClient}, this session never opens a
 * connection: the auth messages and the encrypted messages it produces are
 * relayed to the enclave by the backend, so {@link #attest} is unreachable and
 * the inherited load balancer is never dialed.
 * <p>
 * Not thread safe beyond the synchronization {@link AttestedClient} already
 * provides: a caller driving two handshakes on one session interleaves them.
 */
@Keep
public final class MistysignAttestedSession extends AttestedClient {

    /**
     * Whether the handshake has been completed, as opposed to merely started.
     * <p>
     * Deliberately not derived from {@link AttestedClient#isAttested()}, which
     * reports whether the native AKE object exists. That object is allocated by
     * <code>attest_start</code>, so the inherited answer turns true as soon as
     * the handshake is pending, while the Swift session stays false until
     * <code>authEnd</code> succeeds. Tracking it here keeps the Dart-visible
     * answer identical on both platforms.
     * <p>
     * Left without an initializer on purpose: {@link #attestReset()} is
     * reachable from the superclass, so an explicit <code>= false</code> could
     * run after a reset rather than before it.
     */
    private boolean handshakeComplete;

    private MistysignAttestedSession(@NonNull final LoadBalancer loadBalancer,
                                     @NonNull final ClientConfig.Service serviceConfig,
                                     @NonNull final TransportProtocol transportProtocol) {
        super(loadBalancer, serviceConfig, transportProtocol);
    }

    /**
     * Creates a session that is not yet attested.
     * <p>
     * The service address and trusted identities below are only supplied
     * because {@link AttestedClient} requires them at construction. Both are
     * provided for real later: the responder id by
     * {@link #authBeginRequestData(String)}, and the identities to verify
     * against by {@link #authEnd(byte[], TrustedIdentities)}.
     */
    @NonNull
    public static MistysignAttestedSession create()
            throws InvalidUriException, AttestationException {
        return new MistysignAttestedSession(
                RandomLoadBalancer.create(MistysignUri.unroutable()),
                new ClientConfig.Service().withTrustedIdentities(new TrustedIdentities()),
                TransportProtocol.forGRPC());
    }

    /**
     * Begins the handshake and returns the bytes to relay to the enclave's
     * <code>Auth</code> RPC.
     * <p>
     * <code>responderId</code> is used verbatim and must equal the value the
     * enclave was launched with. It is bound into the handshake, so a mismatch
     * surfaces as a failure in {@link #authEnd(byte[], TrustedIdentities)}
     * rather than here.
     * <p>
     * Beginning a handshake un-attests the session, so restarting one on an
     * already attested session reports false from {@link #isAttested()} until
     * the new handshake completes.
     */
    @NonNull
    public synchronized byte[] authBeginRequestData(@NonNull final String responderId)
            throws MistysignAttestedSessionException {
        handshakeComplete = false;
        try {
            return attestStart(MistysignUri.forResponderId(responderId));
        } catch (InvalidUriException | AttestationException exception) {
            // attestStart already resets on failure; reset here too so that an
            // unparseable responder id leaves the same clean state.
            attestReset();
            throw new MistysignAttestedSessionException(
                    MistysignAttestedSessionException.Code.ATTESTATION_FAILED,
                    "Unable to begin the Mistysign handshake",
                    exception);
        }
    }

    /**
     * Completes the handshake with the enclave's <code>Auth</code> RPC response,
     * verifying its evidence against <code>trustedIdentities</code>.
     * <p>
     * Evidence is only accepted when it matches an identity the caller
     * supplied, so an empty set of identities never attests. The bridge rejects
     * that case before it reaches here, because {@link TrustedIdentities} does
     * not report how many it holds.
     */
    public synchronized void authEnd(@NonNull final byte[] authResponseData,
                                     @NonNull final TrustedIdentities trustedIdentities)
            throws MistysignAttestedSessionException {
        try {
            attestFinish(authResponseData, trustedIdentities);
            handshakeComplete = true;
        } catch (AttestationException exception) {
            throw new MistysignAttestedSessionException(
                    MistysignAttestedSessionException.Code.ATTESTATION_FAILED,
                    "Unable to complete the Mistysign handshake",
                    exception);
        }
    }

    /**
     * Encrypts a serialized request proto and returns the serialized
     * <code>attest.Message</code> to relay to the enclave.
     * <p>
     * <code>plaintext</code> is the serialized request proto itself, and that is
     * exactly what gets encrypted: the returned <code>attest.Message</code> is
     * the <em>result</em> of encryption, never an envelope wrapped around the
     * plaintext beforehand. Wrapping first would leave the enclave parsing an
     * <code>attest.Message</code> where it expects the request.
     */
    @NonNull
    public synchronized byte[] encrypt(@NonNull final byte[] plaintext)
            throws MistysignAttestedSessionException {
        requireAttested();
        try {
            return encryptMessage(new RawMessage(plaintext)).toByteArray();
        } catch (AttestationException exception) {
            throw new MistysignAttestedSessionException(
                    MistysignAttestedSessionException.Code.ENCRYPTION_FAILED,
                    "Unable to encrypt the Mistysign message",
                    exception);
        }
    }

    /**
     * Decrypts a relayed enclave reply and returns the serialized response
     * proto it carried. <code>messageData</code> is a serialized
     * <code>attest.Message</code>.
     */
    @NonNull
    public synchronized byte[] decrypt(@NonNull final byte[] messageData)
            throws MistysignAttestedSessionException {
        requireAttested();
        try {
            return decryptMessage(Attest.Message.parseFrom(messageData))
                    .getData()
                    .toByteArray();
        } catch (IOException | AttestationException exception) {
            throw new MistysignAttestedSessionException(
                    MistysignAttestedSessionException.Code.DECRYPTION_FAILED,
                    "Unable to decrypt the Mistysign message",
                    exception);
        }
    }

    /**
     * Whether {@link #authEnd(byte[], TrustedIdentities)} has completed, so
     * that {@link #encrypt(byte[])} and {@link #decrypt(byte[])} can be used.
     * A pending handshake reports false, matching the Swift session.
     */
    @Override
    public synchronized boolean isAttested() {
        return handshakeComplete;
    }

    /**
     * Clears the completed handshake alongside the native AKE state.
     * <p>
     * Overridden here rather than on {@link #deattest()} because this is the
     * single point every reset passes through, including the ones
     * <code>attestStart</code> and <code>attestFinish</code> perform internally
     * when they fail.
     */
    @Override
    public synchronized void attestReset() {
        handshakeComplete = false;
        super.attestReset();
    }

    private void requireAttested() throws MistysignAttestedSessionException {
        if (!isAttested()) {
            throw new MistysignAttestedSessionException(
                    MistysignAttestedSessionException.Code.NOT_ATTESTED,
                    "Not attested. Complete authBeginRequestData/authEnd first.");
        }
    }

    /**
     * Unreachable: a Mistysign session has no transport of its own to attest.
     * The handshake runs through {@link #authBeginRequestData(String)} and
     * {@link #authEnd(byte[], TrustedIdentities)} instead, and nothing on this
     * class asks {@link AttestedClient} for a network transport.
     */
    @Override
    public synchronized void attest(@NonNull final Transport transport) {
        throw new UnsupportedOperationException(
                "Mistysign is attested through authBeginRequestData and authEnd");
    }

    /**
     * Adapts already serialized protobuf bytes to the {@link AbstractMessageLite}
     * that {@link #encryptMessage} requires.
     * <p>
     * The SDK encrypts whatever <code>toByteArray()</code> returns, and keeps
     * <code>encryptPayload</code> private, so this is the only way to put
     * caller-supplied bytes on the wire unaltered. Typed clients such as
     * {@link mistyswap.AttestedMistySwapClient} do not need it because they
     * parse each request into its generated type first; Mistysign relays
     * arbitrary credential protos and cannot.
     * <p>
     * Only the serialization methods are reachable. The Builder exists solely
     * to satisfy the generic bound and is never instantiated.
     */
    private static final class RawMessage
            extends AbstractMessageLite<RawMessage, RawMessage.Builder> {

        private final byte[] payload;

        RawMessage(@NonNull final byte[] payload) {
            this.payload = payload;
        }

        @Override
        public byte[] toByteArray() {
            return payload.clone();
        }

        @Override
        public int getSerializedSize() {
            return payload.length;
        }

        @Override
        public void writeTo(CodedOutputStream output) throws IOException {
            output.writeRawBytes(payload);
        }

        @Override
        public ByteString toByteString() {
            return ByteString.copyFrom(payload);
        }

        @Override
        public void writeTo(OutputStream output) throws IOException {
            output.write(payload);
        }

        @Override
        public void writeDelimitedTo(OutputStream output) {
            throw new UnsupportedOperationException("RawMessage is serialization only");
        }

        @Override
        public Parser<RawMessage> getParserForType() {
            throw new UnsupportedOperationException("RawMessage is serialization only");
        }

        @Override
        public Builder newBuilderForType() {
            throw new UnsupportedOperationException("RawMessage is serialization only");
        }

        @Override
        public Builder toBuilder() {
            throw new UnsupportedOperationException("RawMessage is serialization only");
        }

        @Override
        public RawMessage getDefaultInstanceForType() {
            throw new UnsupportedOperationException("RawMessage is serialization only");
        }

        @Override
        public boolean isInitialized() {
            return true;
        }

        abstract static class Builder extends AbstractMessageLite.Builder<RawMessage, Builder> {
        }

    }

}
