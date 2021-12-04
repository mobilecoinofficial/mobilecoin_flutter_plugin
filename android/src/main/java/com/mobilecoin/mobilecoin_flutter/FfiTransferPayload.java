package com.mobilecoin.mobilecoin_flutter;

import com.mobilecoin.lib.RistrettoPublic;
import com.mobilecoin.lib.TransferPayload;

import androidx.annotation.Keep;

@Keep
public class FfiTransferPayload {

    private FfiTransferPayload() {
    }

    public static byte[] getBip39Entropy(int payloadId) {
        TransferPayload transferPayload = (TransferPayload) ObjectStorage.objectForKey(payloadId);
        return transferPayload.getBip39Entropy();
    }

    public static String getMemo(int payloadId) {
        TransferPayload transferPayload = (TransferPayload) ObjectStorage.objectForKey(payloadId);
        return transferPayload.getMemo();
    }

    public static int getPublicKey(int payloadId) {
        TransferPayload transferPayload = (TransferPayload) ObjectStorage.objectForKey(payloadId);
        RistrettoPublic publicKey = transferPayload.getPublicKey();
        final int hashCode = publicKey.hashCode();
        ObjectStorage.addObject(hashCode, publicKey);
        return hashCode;
    }
}
