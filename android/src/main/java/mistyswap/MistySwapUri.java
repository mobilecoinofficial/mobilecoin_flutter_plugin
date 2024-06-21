// Copyright (c) 2021-2024 MobileCoin. All rights reserved.

package mistyswap;

import android.net.Uri;

import androidx.annotation.NonNull;

import com.mobilecoin.lib.exceptions.InvalidUriException;
import com.mobilecoin.lib.network.uri.MobileCoinUri;

public final class MistySwapUri extends MobileCoinUri {

    public MistySwapUri(@NonNull final String uriString) throws InvalidUriException {
        super(uriString, new MistySwapScheme());
    }

    public MistySwapUri(@NonNull final Uri uri) throws InvalidUriException {
        super(uri, new MistySwapScheme());
    }

}
