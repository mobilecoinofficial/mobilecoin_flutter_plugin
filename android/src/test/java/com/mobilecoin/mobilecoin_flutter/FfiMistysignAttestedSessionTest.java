// Copyright (c) 2021-2026 MobileCoin. All rights reserved.

package com.mobilecoin.mobilecoin_flutter;

import static org.junit.Assert.assertArrayEquals;
import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNull;
import static org.junit.Assert.assertThrows;
import static org.junit.Assert.assertTrue;

import org.junit.Test;

import java.util.Collections;
import java.util.HashMap;
import java.util.Map;

import mistysign.MistysignAttestedSessionException;
import mistysign.MistysignAttestedSessionException.Code;

/**
 * Covers the bridge's argument validation and its session lookup. A handshake
 * cannot be driven here because {@link com.mobilecoin.lib.TrustedIdentities}
 * constructs through JNI, which the host JVM has no library for.
 */
public class FfiMistysignAttestedSessionTest {

    /** Never registered, so every lookup for it misses. */
    private static final int UNKNOWN_ID = 0x5440;

    /** Registered, but holding something that is not a session. */
    private static final int FOREIGN_ID = 0x5441;

    private static final String MR_SIGNER_HEX =
            "7ee5e29d74623fdbc6fbf1454be6f3bb0b86c12366b7b478ad13353e44de8411";

    @Test
    public void authEnd_rejectsAnEmptyIdentitySet() {
        // The id is deliberately unregistered: an identity set is only visible
        // as empty before it is handed over, so the guard has to fire ahead of
        // the session lookup.
        final MistysignAttestedSessionException exception = assertThrows(
                MistysignAttestedSessionException.class,
                () -> FfiMistysignAttestedSession.authEnd(
                        UNKNOWN_ID,
                        new byte[0],
                        Collections.emptyList(),
                        Collections.emptyList()));

        assertEquals(Code.NO_TRUSTED_IDENTITIES, exception.getCode());
        assertEquals("MISTYSIGN_NO_TRUSTED_IDENTITIES", exception.channelErrorCode());
    }

    @Test
    public void unreadableIdentity_isNotReportedAsAFailedAttestation() {
        // An identity that cannot be read is a local configuration fault, so it
        // must not arrive under the code an enclave whose evidence did not
        // match uses. The two want different triage, and Dart can only tell
        // them apart by the code.
        final MistysignAttestedSessionException exception = assertThrows(
                MistysignAttestedSessionException.class,
                () -> FfiMistysignAttestedSession.measurement(
                        entry("mrSigner", "not hex"), "mrSigner"));

        assertEquals(Code.INVALID_TRUSTED_IDENTITY, exception.getCode());
        assertEquals("MISTYSIGN_INVALID_TRUSTED_IDENTITY", exception.channelErrorCode());
    }

    @Test
    public void authEnd_looksUpTheSessionOnceIdentitiesAreNamed() {
        // One named identity clears the empty-set guard, so the guard is not
        // just firing on every call.
        final MistysignAttestedSessionException exception = assertThrows(
                MistysignAttestedSessionException.class,
                () -> FfiMistysignAttestedSession.authEnd(
                        UNKNOWN_ID,
                        new byte[0],
                        Collections.emptyList(),
                        Collections.singletonList(mrSignerEntry(MR_SIGNER_HEX, 2, 6))));

        assertEquals(Code.NOT_ATTESTED, exception.getCode());
    }

    @Test
    public void everyOperationRejectsAnUnknownSessionId() {
        assertRejectsUnknownSession("authBeginRequestData",
                id -> FfiMistysignAttestedSession.authBeginRequestData(id, "misty.test:443"));
        assertRejectsUnknownSession("encrypt",
                id -> FfiMistysignAttestedSession.encrypt(id, new byte[]{1}));
        assertRejectsUnknownSession("decrypt",
                id -> FfiMistysignAttestedSession.decrypt(id, new byte[]{1}));
        assertRejectsUnknownSession("deattest", FfiMistysignAttestedSession::deattest);
        assertRejectsUnknownSession("isAttested", FfiMistysignAttestedSession::isAttested);
    }

    @Test
    public void everyOperationRejectsAnIdHoldingSomethingElse() {
        // Every handle type shares one object registry, so an id mix-up arrives
        // as a live entry of the wrong type rather than as a miss.
        ObjectStorage.addObject(FOREIGN_ID, "not a session");
        try {
            final MistysignAttestedSessionException exception = assertThrows(
                    MistysignAttestedSessionException.class,
                    () -> FfiMistysignAttestedSession.encrypt(FOREIGN_ID, new byte[]{1}));

            assertEquals(Code.NOT_ATTESTED, exception.getCode());
        } finally {
            ObjectStorage.removeObject(FOREIGN_ID);
        }
    }

    @Test
    public void destroy_releasesTheEntryAndToleratesAnUnknownId() {
        ObjectStorage.addObject(FOREIGN_ID, "not a session");

        // A foreign entry must be dropped rather than cast to a session.
        FfiMistysignAttestedSession.destroy(FOREIGN_ID);
        assertNull(ObjectStorage.objectForKey(FOREIGN_ID));

        // A double dispose from Dart arrives as two destroys.
        FfiMistysignAttestedSession.destroy(FOREIGN_ID);
        FfiMistysignAttestedSession.destroy(UNKNOWN_ID);
    }

    @Test
    public void measurement_decodesHexInEitherCase() throws Exception {
        assertArrayEquals(
                new byte[]{(byte) 0xde, (byte) 0xad, (byte) 0xbe, (byte) 0xef},
                FfiMistysignAttestedSession.measurement(
                        entry("mrSigner", "DeAdBeEf"), "mrSigner"));
    }

    @Test
    public void measurement_decodesTheStagingMrSigner() throws Exception {
        final byte[] measurement = FfiMistysignAttestedSession.measurement(
                entry("mrSigner", MR_SIGNER_HEX), "mrSigner");

        assertEquals(32, measurement.length);
        assertEquals((byte) 0x7e, measurement[0]);
        assertEquals((byte) 0x11, measurement[31]);
    }

    @Test
    public void measurement_rejectsANonHexCharacter() {
        // The SDK's own hex decoder maps a bad character to -1, which turns a
        // typo into a measurement that never matches instead of an error. The
        // index is the start of the failing pair, so it points at the byte
        // rather than at the character.
        assertMalformed("'mrEnclave' contains a non hex character at index 6",
                entry("mrEnclave", "deadbeeg"), "mrEnclave");
        assertMalformed("'mrEnclave' contains a non hex character at index 4",
                entry("mrEnclave", "dead beef "), "mrEnclave");
    }

    @Test
    public void measurement_rejectsANonAsciiDigit() {
        // Character.digit answers for every Unicode digit, so a fullwidth or
        // Arabic-Indic character decodes to a measurement that is well formed
        // and simply wrong: "\uFF13\uFF13" would become 0x33.
        assertMalformed("'mrEnclave' contains a non hex character at index 0",
                entry("mrEnclave", "\uFF13\uFF13"), "mrEnclave");
        assertMalformed("'mrEnclave' contains a non hex character at index 0",
                entry("mrEnclave", "\u0663\u0663"), "mrEnclave");
    }

    @Test
    public void measurement_rejectsTheCharactersEitherSideOfEachHexRange() throws Exception {
        // nibble compares three ranges by hand, so an off by one at any edge
        // would accept a neighbour and decode it to a wrong byte. These are the
        // six characters immediately outside '0'-'9', 'a'-'f' and 'A'-'F'.
        for (final String pair : new String[]{"//", "::", "@@", "GG", "``", "gg"}) {
            assertMalformed("'mrEnclave' contains a non hex character at index 0",
                    entry("mrEnclave", pair), "mrEnclave");
        }

        // The edges themselves still decode, so the guard is not simply
        // rejecting everything near the boundary.
        assertArrayEquals(new byte[]{0x09, (byte) 0xaf, (byte) 0xAF},
                FfiMistysignAttestedSession.measurement(
                        entry("mrEnclave", "09afAF"), "mrEnclave"));
    }

    @Test
    public void measurement_rejectsAnOddLength() {
        assertMalformed("'mrEnclave' is not a whole number of hex encoded bytes",
                entry("mrEnclave", "abc"), "mrEnclave");
    }

    @Test
    public void measurement_rejectsAnEmptyValue() {
        assertMalformed("'mrEnclave' is not a whole number of hex encoded bytes",
                entry("mrEnclave", ""), "mrEnclave");
    }

    @Test
    public void measurement_rejectsAMissingKey() {
        assertMalformed("Trusted identity is missing 'mrSigner'",
                entry("mrEnclave", "dead"), "mrSigner");
    }

    @Test
    public void measurement_namesAWronglyTypedValueRatherThanCallingItMissing() {
        // An mrSigner sent as bytes rather than hex is present, so reporting it
        // as missing sends the reader looking for a key that is right there.
        assertMalformed("'mrSigner' is not a hex encoded string: java.lang.Integer",
                entry("mrSigner", 7), "mrSigner");
        assertMalformed("'mrSigner' is not a hex encoded string: [B",
                entry("mrSigner", new byte[]{1}), "mrSigner");
    }

    @Test
    public void shortValue_narrowsTheFullUnsignedRange() throws Exception {
        assertEquals((short) 0,
                FfiMistysignAttestedSession.shortValue(entry("productId", 0), "productId"));
        assertEquals((short) 2,
                FfiMistysignAttestedSession.shortValue(entry("productId", 2), "productId"));
        // The SDK takes a signed short and reads it as unsigned, so the top of
        // the range arrives as -1 rather than being rejected.
        assertEquals((short) -1,
                FfiMistysignAttestedSession.shortValue(entry("productId", 0xFFFF), "productId"));
    }

    @Test
    public void shortValue_rejectsAValueOutsideTheUnsignedRange() {
        assertMalformedShort("'productId' does not fit in an unsigned 16 bit value: -1",
                entry("productId", -1), "productId");
        assertMalformedShort("'productId' does not fit in an unsigned 16 bit value: 65536",
                entry("productId", 0x10000), "productId");
    }

    @Test
    public void shortValue_namesAWronglyTypedValueRatherThanCallingItMissing() {
        assertMalformedShort("'productId' is not a number: java.lang.String",
                entry("productId", "2"), "productId");
    }

    @Test
    public void shortValue_rejectsAMissingKey() {
        assertMalformedShort("Trusted identity is missing 'minimumSecurityVersion'",
                entry("productId", 2), "minimumSecurityVersion");
    }

    @Test
    public void advisories_splitsTheCommaJoinedValue() throws Exception {
        assertArrayEquals(
                new String[]{"INTEL-SA-00334", "INTEL-SA-00615", "INTEL-SA-00657"},
                FfiMistysignAttestedSession.advisories(
                        entry("configAdvisories",
                                "INTEL-SA-00334,INTEL-SA-00615,INTEL-SA-00657"),
                        "configAdvisories"));
    }

    @Test
    public void advisories_treatsAbsentAndEmptyAsNone() throws Exception {
        // An empty list joins to an empty string, which must not become one
        // empty advisory: advisories are compared verbatim.
        assertEquals(0, FfiMistysignAttestedSession.advisories(
                entry("productId", 2), "configAdvisories").length);
        assertEquals(0, FfiMistysignAttestedSession.advisories(
                entry("configAdvisories", ""), "configAdvisories").length);
    }

    @Test
    public void advisories_rejectsAValueThatIsNotAString() {
        // Reading no advisories out of a malformed value would quietly narrow
        // what the identity tolerates, so an enclave that legitimately carries
        // them would stop attesting with nothing to point at.
        final MistysignAttestedSessionException exception = assertThrows(
                MistysignAttestedSessionException.class,
                () -> FfiMistysignAttestedSession.advisories(
                        entry("hardeningAdvisories", 7), "hardeningAdvisories"));

        assertEquals(Code.INVALID_TRUSTED_IDENTITY, exception.getCode());
        assertEquals("'hardeningAdvisories' is not a comma joined string: java.lang.Integer",
                exception.getMessage());
    }

    private interface SessionOperation {
        void run(int objectId) throws MistysignAttestedSessionException;
    }

    private static void assertRejectsUnknownSession(final String name,
                                                    final SessionOperation operation) {
        final MistysignAttestedSessionException exception = assertThrows(name,
                MistysignAttestedSessionException.class, () -> operation.run(UNKNOWN_ID));

        assertEquals(name, Code.NOT_ATTESTED, exception.getCode());
        assertTrue(name + " should name the id, but said: " + exception.getMessage(),
                exception.getMessage().contains(Integer.toString(UNKNOWN_ID)));
    }

    private static void assertMalformed(final String expectedMessage,
                                        final Map<String, Object> entry,
                                        final String key) {
        final MistysignAttestedSessionException exception = assertThrows(
                MistysignAttestedSessionException.class,
                () -> FfiMistysignAttestedSession.measurement(entry, key));

        assertEquals(Code.INVALID_TRUSTED_IDENTITY, exception.getCode());
        assertEquals(expectedMessage, exception.getMessage());
    }

    private static void assertMalformedShort(final String expectedMessage,
                                             final Map<String, Object> entry,
                                             final String key) {
        final MistysignAttestedSessionException exception = assertThrows(
                MistysignAttestedSessionException.class,
                () -> FfiMistysignAttestedSession.shortValue(entry, key));

        assertEquals(Code.INVALID_TRUSTED_IDENTITY, exception.getCode());
        assertEquals(expectedMessage, exception.getMessage());
    }

    private static Map<String, Object> entry(final String key, final Object value) {
        final Map<String, Object> entry = new HashMap<>();
        entry.put(key, value);
        return entry;
    }

    private static Map<String, Object> mrSignerEntry(final String mrSigner,
                                                     final int productId,
                                                     final int minimumSecurityVersion) {
        final Map<String, Object> entry = entry("mrSigner", mrSigner);
        entry.put("productId", productId);
        entry.put("minimumSecurityVersion", minimumSecurityVersion);
        entry.put("hardeningAdvisories", "");
        entry.put("configAdvisories", "");
        return entry;
    }
}
