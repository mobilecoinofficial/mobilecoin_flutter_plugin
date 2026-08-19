// Copyright (c) 2021-2026 MobileCoin. All rights reserved.

package mistysign;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNull;
import static org.junit.Assert.assertSame;

import org.junit.Test;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import mistysign.MistysignAttestedSessionException.Code;

public class MistysignAttestedSessionExceptionTest {

    @Test
    public void channelErrorCode_matchesTheDartErrorCodes() {
        final List<String> codes = new ArrayList<>();
        for (final Code code : Code.values()) {
            codes.add(new MistysignAttestedSessionException(code, "message").channelErrorCode());
        }

        // These strings are the cross-platform contract. A code added here
        // without its Dart counterpart reaches callers as unknown.
        assertEquals(Arrays.asList(
                "MISTYSIGN_NOT_ATTESTED",
                "MISTYSIGN_NO_TRUSTED_IDENTITIES",
                "MISTYSIGN_ATTESTATION_FAILED",
                "MISTYSIGN_ENCRYPTION_FAILED",
                "MISTYSIGN_DECRYPTION_FAILED"), codes);
    }

    @Test
    public void message_foldsInTheCauseMessage() {
        // Only the message survives the trip to Dart, so dropping the cause
        // makes every failure of a kind read identically.
        final MistysignAttestedSessionException exception = new MistysignAttestedSessionException(
                Code.ATTESTATION_FAILED,
                "Unable to complete the Mistysign handshake",
                new IllegalStateException("responder id mismatch"));

        assertEquals("Unable to complete the Mistysign handshake: responder id mismatch",
                exception.getMessage());
    }

    @Test
    public void message_omitsACauseWithNoMessageOfItsOwn() {
        // Wrapped runtime failures often have none, and ": null" says nothing.
        assertEquals("Unable to encrypt the Mistysign message",
                new MistysignAttestedSessionException(
                        Code.ENCRYPTION_FAILED,
                        "Unable to encrypt the Mistysign message",
                        new NullPointerException()).getMessage());

        assertEquals("Unable to encrypt the Mistysign message",
                new MistysignAttestedSessionException(
                        Code.ENCRYPTION_FAILED,
                        "Unable to encrypt the Mistysign message",
                        new IllegalStateException("")).getMessage());
    }

    @Test
    public void message_isUnchangedWithoutACause() {
        final MistysignAttestedSessionException exception = new MistysignAttestedSessionException(
                Code.NOT_ATTESTED, "Not attested.");

        assertEquals("Not attested.", exception.getMessage());
        assertNull(exception.getCause());
    }

    @Test
    public void cause_isRetainedForLogging() {
        final IllegalStateException cause = new IllegalStateException("boom");

        assertSame(cause, new MistysignAttestedSessionException(
                Code.DECRYPTION_FAILED, "Unable to decrypt", cause).getCause());
    }
}
