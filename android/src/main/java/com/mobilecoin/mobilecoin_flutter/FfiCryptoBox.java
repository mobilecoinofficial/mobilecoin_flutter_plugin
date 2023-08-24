package com.mobilecoin.mobilecoin_flutter;

import androidx.annotation.Keep;

import com.mobilecoin.lib.DefaultVersionedCryptoBox;
import com.mobilecoin.lib.RistrettoPrivate;
import com.mobilecoin.lib.RistrettoPublic;

@Keep
public class FfiCryptoBox {

    private FfiCryptoBox() { }

    public static byte[] encrypt(byte[] data, int ristrettoPublicId) {
        RistrettoPublic ristrettoPublic = (RistrettoPublic) ObjectStorage.objectForKey(ristrettoPublicId);
        final DefaultVersionedCryptoBox cryptoBox = new DefaultVersionedCryptoBox();
        return cryptoBox.versionedCryptoBoxEncrypt(ristrettoPublic, data);
    }

    public static byte[] decrypt(byte[] encrypted, int ristrettoPrivateId) throws Exception {
        RistrettoPrivate ristrettoPrivate = (RistrettoPrivate) ObjectStorage.objectForKey(ristrettoPrivateId);
        final DefaultVersionedCryptoBox cryptoBox = new DefaultVersionedCryptoBox();
        return cryptoBox.versionedCryptoBoxDecrypt(ristrettoPrivate, encrypted);
    }
}
