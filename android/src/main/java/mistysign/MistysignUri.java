// Copyright (c) 2021-2026 MobileCoin. All rights reserved.

package mistysign;

import android.net.Uri;

import androidx.annotation.NonNull;

import com.mobilecoin.lib.exceptions.InvalidUriException;
import com.mobilecoin.lib.network.uri.MobileCoinUri;

public final class MistysignUri extends MobileCoinUri {

    private static final String RESPONDER_ID_PARAMETER = "responder-id";

    /**
     * Reserved by RFC 2606, so it can never resolve. Used where
     * <code>AttestedClient</code> demands a URI that this session never dials.
     */
    private static final String UNROUTABLE_HOST = "mistysign.invalid";

    public MistysignUri(@NonNull final String uriString) throws InvalidUriException {
        super(uriString, new MistysignScheme());
    }

    public MistysignUri(@NonNull final Uri uri) throws InvalidUriException {
        super(uri, new MistysignScheme());
    }

    /**
     * Builds a URI that carries <code>responderId</code> verbatim.
     * <p>
     * <code>AttestedClient.attestStart</code> only accepts a
     * {@link MobileCoinUri}, and by default derives the responder id from the
     * URI's host and port. Mistysign is attested through a responder id that is
     * configured on the service rather than dialed by the client, so the
     * "responder-id" query parameter is used instead, which
     * <code>attestStart</code> prefers over the derived value.
     * <p>
     * The authority is a fixed placeholder rather than the responder id's own
     * host. Nothing reads it -- the id reaches Rust unaltered through the query
     * parameter, exactly as it does on iOS -- and deriving one would mean
     * parsing a value that neither platform otherwise parses, which is how a
     * bracketed IPv6 literal ends up mangled.
     */
    @NonNull
    public static MistysignUri forResponderId(@NonNull final String responderId)
            throws InvalidUriException {
        // An empty parameter is the one input that must not reach attestStart:
        // it fails the parameter's isEmpty check and silently falls back to
        // deriving the responder id from the placeholder authority below, which
        // would attest against "mistysign.invalid:443" instead of failing.
        if (responderId.isEmpty()) {
            throw new InvalidUriException("Responder id must not be empty");
        }

        return new MistysignUri(new Uri.Builder()
                .scheme(new MistysignScheme().secureScheme())
                .encodedAuthority(UNROUTABLE_HOST)
                .appendQueryParameter(RESPONDER_ID_PARAMETER, responderId)
                .build());
    }

    /**
     * A URI that stands in for the service address {@link com.mobilecoin.lib.AttestedClient}
     * requires at construction.
     * <p>
     * A Mistysign session never opens a connection -- the handshake and the
     * encrypted messages are relayed to the enclave by the backend -- and the
     * responder id that actually matters is supplied later, per handshake, by
     * {@link #forResponderId}. Pointing at an unroutable host keeps a
     * mistakenly dialed session from reaching anything real.
     */
    @NonNull
    public static MistysignUri unroutable() throws InvalidUriException {
        return new MistysignUri(new Uri.Builder()
                .scheme(new MistysignScheme().secureScheme())
                .encodedAuthority(UNROUTABLE_HOST)
                .build());
    }

}
