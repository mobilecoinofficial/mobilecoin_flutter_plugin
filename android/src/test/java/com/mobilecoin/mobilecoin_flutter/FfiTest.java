// Copyright (c) 2021-2026 MobileCoin. All rights reserved.

package com.mobilecoin.mobilecoin_flutter;

import static org.junit.Assert.assertEquals;

import org.junit.Test;

import mistysign.MistysignAttestedSessionException;
import mistysign.MistysignAttestedSessionException.Code;

/**
 * Covers the error-code seam only. The rest of {@link Ffi} posts to the main
 * looper, which needs an Android runtime.
 */
public class FfiTest {

    @Test
    public void errorCodeFor_usesTheThrowablesOwnCode() {
        assertEquals("MISTYSIGN_DECRYPTION_FAILED", Ffi.errorCodeFor(
                new MistysignAttestedSessionException(Code.DECRYPTION_FAILED, "no")));
    }

    @Test
    public void errorCodeFor_fallsBackToTheCatchAllCode() {
        // Without a declared code a failure arrives as NATIVE, which leaves
        // callers matching on message strings to tell one kind from another.
        assertEquals("NATIVE", Ffi.errorCodeFor(new IllegalStateException("no")));
    }
}
