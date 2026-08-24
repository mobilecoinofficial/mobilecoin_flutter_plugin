// Copyright (c) 2021-2026 MobileCoin. All rights reserved.

package mistysign;

import androidx.annotation.NonNull;

import com.mobilecoin.lib.network.uri.MobileCoinScheme;

public final class MistysignScheme implements MobileCoinScheme {

    @NonNull
    @Override
    public String secureScheme() {
        return "mistysign";
    }

    @NonNull
    @Override
    public String insecureScheme() {
        return "insecure-mistysign";
    }

    // Ports match MISTYSIGN_DEFAULT_SECURE_PORT / MISTYSIGN_DEFAULT_INSECURE_PORT
    // in MobileCoin-Swift's McConstants.

    @Override
    public int securePort() {
        return 443;
    }

    @Override
    public int insecurePort() {
        return 3223;
    }

}
