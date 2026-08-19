// Copyright (c) 2021-2026 MobileCoin. All rights reserved.

package com.mobilecoin.mobilecoin_flutter;

import androidx.annotation.Keep;
import androidx.annotation.NonNull;

import com.mobilecoin.lib.TrustedIdentities;
import com.mobilecoin.lib.exceptions.AttestationException;
import com.mobilecoin.lib.exceptions.InvalidUriException;

import java.util.List;
import java.util.Map;

import mistysign.MistysignAttestedSession;
import mistysign.MistysignAttestedSessionException;

/**
 * Bridges {@link MistysignAttestedSession} to the plugin's method channel,
 * mirroring <code>FfiMistysignAttestedSession</code> on iOS.
 * <p>
 * Trusted identities arrive as the channel maps built by the Dart
 * <code>MistysignMrEnclave</code> and <code>MistysignMrSigner</code> types,
 * with their advisories comma joined into a single string.
 */
@Keep
public final class FfiMistysignAttestedSession {

    private static final String MR_ENCLAVE_KEY = "mrEnclave";
    private static final String MR_SIGNER_KEY = "mrSigner";
    private static final String PRODUCT_ID_KEY = "productId";
    private static final String MINIMUM_SECURITY_VERSION_KEY = "minimumSecurityVersion";
    private static final String CONFIG_ADVISORIES_KEY = "configAdvisories";
    private static final String HARDENING_ADVISORIES_KEY = "hardeningAdvisories";

    private static final String ADVISORY_SEPARATOR = ",";

    private FfiMistysignAttestedSession() {
    }

    public static int create() throws MistysignAttestedSessionException {
        try {
            final MistysignAttestedSession session = MistysignAttestedSession.create();
            final int hashCode = session.hashCode();
            ObjectStorage.addObject(hashCode, session);
            return hashCode;
        } catch (InvalidUriException | AttestationException exception) {
            throw new MistysignAttestedSessionException(
                    MistysignAttestedSessionException.Code.ATTESTATION_FAILED,
                    "Unable to create the Mistysign session",
                    exception);
        }
    }

    @NonNull
    public static byte[] authBeginRequestData(final int objectId, @NonNull final String responderId)
            throws MistysignAttestedSessionException {
        return sessionFor(objectId).authBeginRequestData(responderId);
    }

    public static void authEnd(final int objectId,
                               @NonNull final byte[] authResponseData,
                               @NonNull final List<Map<String, Object>> mrEnclaves,
                               @NonNull final List<Map<String, Object>> mrSigners)
            throws MistysignAttestedSessionException {
        // Evidence is only accepted when it matches a supplied identity, so an
        // empty set can never attest. Rejecting it here keeps the failure
        // legible: TrustedIdentities does not report how many it holds, so the
        // session itself cannot tell an empty set from a populated one.
        if (mrEnclaves.isEmpty() && mrSigners.isEmpty()) {
            throw new MistysignAttestedSessionException(
                    MistysignAttestedSessionException.Code.NO_TRUSTED_IDENTITIES,
                    "Attestation named no trusted identities to verify against.");
        }

        sessionFor(objectId).authEnd(
                authResponseData,
                trustedIdentities(mrEnclaves, mrSigners));
    }

    @NonNull
    public static byte[] encrypt(final int objectId, @NonNull final byte[] plaintext)
            throws MistysignAttestedSessionException {
        return sessionFor(objectId).encrypt(plaintext);
    }

    @NonNull
    public static byte[] decrypt(final int objectId, @NonNull final byte[] messageData)
            throws MistysignAttestedSessionException {
        return sessionFor(objectId).decrypt(messageData);
    }

    public static void deattest(final int objectId) throws MistysignAttestedSessionException {
        sessionFor(objectId).deattest();
    }

    public static boolean isAttested(final int objectId)
            throws MistysignAttestedSessionException {
        return sessionFor(objectId).isAttested();
    }

    public static void destroy(final int objectId) {
        final Object session = ObjectStorage.objectForKey(objectId);
        if (session instanceof MistysignAttestedSession) {
            // Drop the attested state rather than waiting for finalization,
            // which is what holds the session's native handle.
            ((MistysignAttestedSession) session).deattest();
        }
        ObjectStorage.removeObject(objectId);
    }

    @NonNull
    private static MistysignAttestedSession sessionFor(final int objectId)
            throws MistysignAttestedSessionException {
        final Object session = ObjectStorage.objectForKey(objectId);
        if (!(session instanceof MistysignAttestedSession)) {
            throw new MistysignAttestedSessionException(
                    MistysignAttestedSessionException.Code.NOT_ATTESTED,
                    "No Mistysign session for id " + objectId
                            + ". It was never created, or has been destroyed.");
        }
        return (MistysignAttestedSession) session;
    }

    @NonNull
    private static TrustedIdentities trustedIdentities(
            @NonNull final List<Map<String, Object>> mrEnclaves,
            @NonNull final List<Map<String, Object>> mrSigners)
            throws MistysignAttestedSessionException {
        try {
            final TrustedIdentities identities = new TrustedIdentities();

            for (final Map<String, Object> entry : mrEnclaves) {
                identities.addMrEnclaveIdentity(
                        measurement(entry, MR_ENCLAVE_KEY),
                        advisories(entry, CONFIG_ADVISORIES_KEY),
                        advisories(entry, HARDENING_ADVISORIES_KEY));
            }

            for (final Map<String, Object> entry : mrSigners) {
                identities.addMrSignerIdentity(
                        measurement(entry, MR_SIGNER_KEY),
                        shortValue(entry, PRODUCT_ID_KEY),
                        shortValue(entry, MINIMUM_SECURITY_VERSION_KEY),
                        advisories(entry, CONFIG_ADVISORIES_KEY),
                        advisories(entry, HARDENING_ADVISORIES_KEY));
            }

            return identities;
        } catch (AttestationException exception) {
            throw new MistysignAttestedSessionException(
                    MistysignAttestedSessionException.Code.ATTESTATION_FAILED,
                    "Unable to build the trusted identities",
                    exception);
        }
    }

    /**
     * Decodes a hex measurement, rejecting anything malformed.
     * <p>
     * {@link com.mobilecoin.lib.util.Hex#toByteArray} maps non hex characters
     * to -1 rather than failing, which would turn a typo into a measurement
     * that simply never matches. Failing here says why.
     */
    @NonNull
    private static byte[] measurement(@NonNull final Map<String, Object> entry,
                                      @NonNull final String key)
            throws MistysignAttestedSessionException {
        final Object value = entry.get(key);
        if (!(value instanceof String)) {
            throw malformed("Trusted identity is missing '" + key + "'");
        }

        final String hex = (String) value;
        if (hex.isEmpty() || hex.length() % 2 != 0) {
            throw malformed("'" + key + "' is not a whole number of hex encoded bytes");
        }

        final byte[] measurement = new byte[hex.length() / 2];
        for (int i = 0; i < measurement.length; ++i) {
            final int high = Character.digit(hex.charAt(i * 2), 16);
            final int low = Character.digit(hex.charAt(i * 2 + 1), 16);
            if (high < 0 || low < 0) {
                throw malformed("'" + key + "' is not hex encoded");
            }
            measurement[i] = (byte) ((high << 4) + low);
        }
        return measurement;
    }

    private static short shortValue(@NonNull final Map<String, Object> entry,
                                    @NonNull final String key)
            throws MistysignAttestedSessionException {
        final Object value = entry.get(key);
        if (!(value instanceof Number)) {
            throw malformed("Trusted identity is missing '" + key + "'");
        }

        final int intValue = ((Number) value).intValue();
        if (intValue < 0 || intValue > 0xFFFF) {
            throw malformed("'" + key + "' does not fit in an unsigned 16 bit value: " + intValue);
        }
        return (short) intValue;
    }

    /**
     * Splits the comma joined advisories the Dart side sends.
     * <p>
     * An absent value means none, and so does an empty one: <code>"".split(",")</code>
     * would otherwise yield a single empty advisory. A present value has to be
     * the string the channel contract specifies, because reading no advisories
     * out of a malformed one would quietly narrow what the identity tolerates,
     * leaving an enclave that legitimately carries them unable to attest with
     * nothing to point at.
     */
    @NonNull
    private static String[] advisories(@NonNull final Map<String, Object> entry,
                                       @NonNull final String key)
            throws MistysignAttestedSessionException {
        final Object value = entry.get(key);
        if (value == null) {
            return new String[0];
        }
        if (!(value instanceof String)) {
            throw malformed("'" + key + "' is not a comma joined string: "
                    + value.getClass().getName());
        }

        final String joined = (String) value;
        return joined.isEmpty() ? new String[0] : joined.split(ADVISORY_SEPARATOR);
    }

    @NonNull
    private static MistysignAttestedSessionException malformed(@NonNull final String message) {
        return new MistysignAttestedSessionException(
                MistysignAttestedSessionException.Code.ATTESTATION_FAILED, message);
    }

}
