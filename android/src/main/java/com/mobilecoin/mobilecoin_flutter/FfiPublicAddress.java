package com.mobilecoin.mobilecoin_flutter;

import androidx.annotation.Keep;

import com.mobilecoin.lib.PublicAddress;
import com.mobilecoin.lib.exceptions.SerializationException;

@Keep
public class FfiPublicAddress {

    private FfiPublicAddress() {}

    public static int fromBytes(byte[] serializedBytes) throws SerializationException {
        PublicAddress publicAddress = PublicAddress.fromBytes(serializedBytes);
        final int hashCode = publicAddress.hashCode();
        ObjectStorage.addObject(hashCode, publicAddress);
        return hashCode;
    }

    public static byte[] toByteArray(int addressId) {
        PublicAddress publicAddress = (PublicAddress)ObjectStorage.objectForKey(addressId);
        return publicAddress.toByteArray();
    }

    public static byte[] getAddressHash(int addressId) {
        PublicAddress publicAddress = (PublicAddress)ObjectStorage.objectForKey(addressId);
        return publicAddress.calculateAddressHash().getHashData();
    }
}
