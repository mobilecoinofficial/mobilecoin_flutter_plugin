// Copyright (c) 2021-2024 MobileCoin. All rights reserved.

package com.mobilecoin.mobilecoin_flutter;

import androidx.annotation.Keep;

import com.mobilecoin.lib.RistrettoPublic;
import com.mobilecoin.lib.exceptions.SerializationException;

@Keep
public class FfiRistrettoPublic {

    private FfiRistrettoPublic() {}

    public static int fromBytes(byte[] serializedBytes) throws SerializationException {
        RistrettoPublic ristrettoPublic = RistrettoPublic.fromBytes(serializedBytes);
        final int hashCode = ristrettoPublic.hashCode();
        ObjectStorage.addObject(hashCode, ristrettoPublic);
        return hashCode;
    }

    public static byte[] toByteArray(int ristrettoPublicId) {
        RistrettoPublic ristrettoPublic = (RistrettoPublic)ObjectStorage.objectForKey(ristrettoPublicId);
        return ristrettoPublic.getKeyBytes();
    }
}
