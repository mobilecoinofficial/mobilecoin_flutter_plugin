package com.mobilecoin.mobilecoin_flutter;

import com.mobilecoin.lib.PaymentRequest;
import com.mobilecoin.lib.PublicAddress;
import com.mobilecoin.lib.UnsignedLong;

import androidx.annotation.Keep;

@Keep
public class FfiPaymentRequest {

    private FfiPaymentRequest() {
    }

    public static String getValue(int requestId) {
        PaymentRequest paymentRequest = (PaymentRequest) ObjectStorage.objectForKey(requestId);
        UnsignedLong value = paymentRequest.getValue();
        return value.toString();
    }

    public static String getMemo(int requestId) {
        PaymentRequest paymentRequest = (PaymentRequest) ObjectStorage.objectForKey(requestId);
        return paymentRequest.getMemo();
    }

    public static int getPublicAddress(int requestId) {
        PaymentRequest paymentRequest = (PaymentRequest) ObjectStorage.objectForKey(requestId);
        PublicAddress publicAddress = paymentRequest.getPublicAddress();
        final int hashCode = publicAddress.hashCode();
        ObjectStorage.addObject(hashCode, publicAddress);
        return hashCode;
    }
}
