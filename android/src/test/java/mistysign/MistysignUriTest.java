// Copyright (c) 2021-2026 MobileCoin. All rights reserved.

package mistysign;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertNull;
import static org.junit.Assert.assertThrows;
import static org.junit.Assert.assertTrue;

import com.mobilecoin.lib.exceptions.InvalidUriException;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.robolectric.RobolectricTestRunner;

/**
 * Runs under Robolectric because the URI is parsed through
 * {@code android.net.Uri}.
 * <p>
 * The assertions read the "responder-id" query parameter and the authority,
 * which is the pair the SDK chooses between: a parameter that is absent or
 * empty falls back to the authority, so getting either wrong attests against
 * the unroutable placeholder instead of the enclave.
 */
@RunWith(RobolectricTestRunner.class)
public class MistysignUriTest {

    private static final String RESPONDER_ID = "misty.example.com:443";

    @Test
    public void forResponderId_carriesTheResponderIdVerbatim() throws Exception {
        final MistysignUri uri = MistysignUri.forResponderId(RESPONDER_ID);

        assertEquals(RESPONDER_ID, uri.getUri().getQueryParameter("responder-id"));
    }

    @Test
    public void forResponderId_leavesAResponderIdWithNoPortAlone() throws Exception {
        // The port is defaulted before the id reaches here, so that both
        // platforms send byte-identical strings. Nothing here may add one.
        final MistysignUri uri = MistysignUri.forResponderId("misty.example.com");

        assertEquals("misty.example.com", uri.getUri().getQueryParameter("responder-id"));
    }

    @Test
    public void forResponderId_survivesCharactersThatNeedEncoding() throws Exception {
        // A bracketed IPv6 literal is what a home-rolled authority split
        // mangles. The query parameter round-trips it untouched.
        final String ipv6 = "[2001:db8::1]:443";
        final MistysignUri uri = MistysignUri.forResponderId(ipv6);

        assertEquals(ipv6, uri.getUri().getQueryParameter("responder-id"));
    }

    @Test
    public void forResponderId_usesThePlaceholderAuthorityAndSecurePort() throws Exception {
        final MistysignUri uri = MistysignUri.forResponderId(RESPONDER_ID);

        assertEquals("mistysign.invalid", uri.getUri().getHost());
        // The default port is filled in from the scheme, and has to match the
        // secure port the iOS session uses.
        assertEquals(443, uri.getUri().getPort());
        assertTrue(uri.isTlsEnabled());
    }

    @Test
    public void forResponderId_rejectsAnEmptyResponderId() {
        // An empty parameter falls back to the placeholder authority, which
        // would attest against "mistysign.invalid:443" instead of failing.
        assertThrows(InvalidUriException.class, () -> MistysignUri.forResponderId(""));
    }

    @Test
    public void unroutable_namesNoResponderIdAndCannotResolve() throws Exception {
        final MistysignUri uri = MistysignUri.unroutable();

        assertNull(uri.getUri().getQueryParameter("responder-id"));
        assertEquals("mistysign.invalid", uri.getUri().getHost());
        assertEquals(443, uri.getUri().getPort());
    }

    @Test
    public void constructor_rejectsAnotherServicesScheme() {
        // The scheme guard keeps another service's URI from being handed to a
        // Mistysign session.
        assertThrows(InvalidUriException.class,
                () -> new MistysignUri("fog-view://fog.example.com:443"));
    }

    @Test
    public void constructor_acceptsTheInsecureSchemeWithItsOwnPort() throws Exception {
        final MistysignUri uri = new MistysignUri("insecure-mistysign://localhost");

        assertEquals(3223, uri.getUri().getPort());
        assertFalse(uri.isTlsEnabled());
    }
}
