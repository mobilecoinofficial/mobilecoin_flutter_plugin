// Copyright (c) 2021-2026 MobileCoin. All rights reserved.

package mistysign;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.mobilecoin.mobilecoin_flutter.ChannelErrorCode;

/**
 * A {@link MistysignAttestedSession} failure, discriminated by {@link Code} so
 * that the Dart side can react without matching on message strings.
 * <p>
 * The codes mirror <code>MistysignAttestedSessionError</code> in
 * MobileCoin-Swift, so both platforms surface the same
 * <code>MistysignAttestedSessionErrorCode</code> to callers.
 */
public final class MistysignAttestedSessionException extends Exception implements ChannelErrorCode {

    public enum Code {
        NOT_ATTESTED("MISTYSIGN_NOT_ATTESTED"),
        NO_TRUSTED_IDENTITIES("MISTYSIGN_NO_TRUSTED_IDENTITIES"),
        ATTESTATION_FAILED("MISTYSIGN_ATTESTATION_FAILED"),
        ENCRYPTION_FAILED("MISTYSIGN_ENCRYPTION_FAILED"),
        DECRYPTION_FAILED("MISTYSIGN_DECRYPTION_FAILED");

        private final String channelErrorCode;

        Code(@NonNull final String channelErrorCode) {
            this.channelErrorCode = channelErrorCode;
        }

        @NonNull
        String channelErrorCode() {
            return channelErrorCode;
        }
    }

    private final Code code;

    public MistysignAttestedSessionException(@NonNull final Code code,
                                             @NonNull final String message) {
        this(code, message, null);
    }

    public MistysignAttestedSessionException(@NonNull final Code code,
                                             @NonNull final String message,
                                             @Nullable final Throwable cause) {
        super(withCause(message, cause), cause);
        this.code = code;
    }

    /**
     * Folds the cause's message into this one, because only the message
     * survives the trip to Dart and wrapping without it makes every failure of
     * a given kind read identically.
     * <p>
     * A cause with no message of its own contributes nothing, rather than a
     * ": null" suffix. Wrapped runtime failures often have none.
     */
    @NonNull
    private static String withCause(@NonNull final String message,
                                    @Nullable final Throwable cause) {
        final String causeMessage = cause == null ? null : cause.getLocalizedMessage();
        if (causeMessage == null || causeMessage.isEmpty()) {
            return message;
        }
        return message + ": " + causeMessage;
    }

    @NonNull
    public Code getCode() {
        return code;
    }

    @NonNull
    @Override
    public String channelErrorCode() {
        return code.channelErrorCode();
    }

}
