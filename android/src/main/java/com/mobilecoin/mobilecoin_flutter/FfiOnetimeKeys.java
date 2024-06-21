// Copyright (c) 2021-2024 MobileCoin. All rights reserved.

package com.mobilecoin.mobilecoin_flutter;

import androidx.annotation.Keep;

import com.mobilecoin.lib.OnetimeKeys;
import com.mobilecoin.lib.RistrettoPublic;
import com.mobilecoin.lib.RistrettoPrivate;


@Keep
public class FfiOnetimeKeys {

    private FfiOnetimeKeys() {
    }

    public static int createTxOutPublicKey(final int txOutPrivateKeyId, final int recipientSpendPublicKeyId) {
        final RistrettoPrivate privateKey = (RistrettoPrivate) ObjectStorage.objectForKey(txOutPrivateKeyId);
        final RistrettoPublic publicKey = (RistrettoPublic) ObjectStorage.objectForKey(recipientSpendPublicKeyId);
        final RistrettoPublic txOutPublicKey = OnetimeKeys.createTxOutPublicKey(privateKey, publicKey);
        final int hashCode = txOutPublicKey.hashCode();
        ObjectStorage.addObject(hashCode, txOutPublicKey);
        return hashCode;
    }
    
}
