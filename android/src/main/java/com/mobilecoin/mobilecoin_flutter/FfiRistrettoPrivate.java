// Copyright (c) 2021-2024 MobileCoin. All rights reserved.

package com.mobilecoin.mobilecoin_flutter;

import androidx.annotation.Keep;

import com.mobilecoin.lib.RistrettoPrivate;
import com.mobilecoin.lib.exceptions.SerializationException;

@Keep
public class FfiRistrettoPrivate {

    private FfiRistrettoPrivate() {}

    public static int fromBytes(byte[] serializedBytes) throws SerializationException {
        RistrettoPrivate ristrettoPrivate = RistrettoPrivate.fromBytes(serializedBytes);
        final int hashCode = ristrettoPrivate.hashCode();
        ObjectStorage.addObject(hashCode, ristrettoPrivate);
        return hashCode;
    }

    public static byte[] toByteArray(int ristrettoPrivateId) {
        RistrettoPrivate ristrettoPrivate = (RistrettoPrivate)ObjectStorage.objectForKey(ristrettoPrivateId);
        return ristrettoPrivate.getKeyBytes();
    }
}
