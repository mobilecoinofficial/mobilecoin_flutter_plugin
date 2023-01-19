package com.mobilecoin.mobilecoin_flutter;

import androidx.annotation.Keep;

import com.mobilecoin.lib.AccountKey;
import com.mobilecoin.lib.PublicAddress;
import com.mobilecoin.lib.DefaultVersionedCryptoBox;

@Keep
public class FfiCryptoBox {

    private FfiCryptoBox() { }

    public static byte[] encrypt(byte[] data, int publicAddressId)
            throws Exception {
        PublicAddress publicAddress = (PublicAddress) ObjectStorage.objectForKey(publicAddressId);
        final DefaultVersionedCryptoBox cryptoBox = new DefaultVersionedCryptoBox();
        return cryptoBox.versionedCryptoBoxEncrypt(publicAddress.getSpendKey(), data);
    }

    public static byte[] decrypt(byte[] encrypted, int accountKeyId) throws Exception {
        AccountKey accountKey = (AccountKey) ObjectStorage.objectForKey(accountKeyId);
        final DefaultVersionedCryptoBox cryptoBox = new DefaultVersionedCryptoBox();
        return cryptoBox.versionedCryptoBoxDecrypt(accountKey.getDefaultSubAddressSpendKey(), encrypted);
    }
}