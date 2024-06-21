// Copyright (c) 2021-2024 MobileCoin. All rights reserved.

package com.mobilecoin.mobilecoin_flutter;

import android.net.Uri;

import androidx.annotation.Keep;

import com.mobilecoin.lib.AccountKey;
import com.mobilecoin.lib.PublicAddress;
import com.mobilecoin.lib.exceptions.InvalidUriException;
import com.mobilecoin.lib.exceptions.BadEntropyException;

@Keep
public class FfiAccountKey {

    private FfiAccountKey() {
    }

    public static int fromBip39Entropy(byte[] entropy, String fogReportUri, String reportId, byte[] fogAuthoritySpki)
            throws InvalidUriException, BadEntropyException {
        AccountKey accountKey = AccountKey.fromBip39Entropy(entropy, 0, Uri.parse(fogReportUri), reportId,
                fogAuthoritySpki);
        final int hashCode = accountKey.hashCode();
        ObjectStorage.addObject(hashCode, accountKey);
        return hashCode;
    }

    public static int getPublicAddress(int addressId) {
        AccountKey accountKey = (AccountKey) ObjectStorage.objectForKey(addressId);
        PublicAddress publicAddress = accountKey.getPublicAddress();
        final int hashCode = publicAddress.hashCode();
        ObjectStorage.addObject(hashCode, publicAddress);
        return hashCode;
    }
}