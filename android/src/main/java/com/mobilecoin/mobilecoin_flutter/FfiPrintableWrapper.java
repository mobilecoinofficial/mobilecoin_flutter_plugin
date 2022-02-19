package com.mobilecoin.mobilecoin_flutter;

import com.mobilecoin.lib.PaymentRequest;
import com.mobilecoin.lib.PrintableWrapper;
import com.mobilecoin.lib.TransferPayload;
import com.mobilecoin.lib.PublicAddress;
import com.mobilecoin.lib.exceptions.SerializationException;

import androidx.annotation.Keep;

import java.util.Objects;

@Keep
public class FfiPrintableWrapper {

    private FfiPrintableWrapper() {
    }

    public static int fromB58String(String b58String) throws SerializationException {
        PrintableWrapper printableWrapper = PrintableWrapper.fromB58String(b58String);
        final int hashCode = printableWrapper.hashCode();
        ObjectStorage.addObject(hashCode, printableWrapper);
        return hashCode;
    }

    public static String toB58String(int wrapperId) throws SerializationException {
        PrintableWrapper printableWrapper = (PrintableWrapper) ObjectStorage.objectForKey(wrapperId);
        return printableWrapper.toB58String();
    }

    public static int fromPublicAddress(int publicAddressId) throws SerializationException {
        PublicAddress publicAddress = (PublicAddress) ObjectStorage.objectForKey(publicAddressId);
        PrintableWrapper printableWrapper = PrintableWrapper.fromPublicAddress(publicAddress);
        final int hashCode = printableWrapper.hashCode();
        ObjectStorage.addObject(hashCode, printableWrapper);
        return hashCode;
    }

    public static boolean hasPublicAddress(int wrapperId) {
        PrintableWrapper printableWrapper = (PrintableWrapper) ObjectStorage.objectForKey(wrapperId);
        return printableWrapper.hasPublicAddress();
    }

    public static int getPublicAddress(int wrapperId) {
        PrintableWrapper printableWrapper = (PrintableWrapper) ObjectStorage.objectForKey(wrapperId);
        PublicAddress publicAddress = printableWrapper.getPublicAddress();
        Objects.requireNonNull(publicAddress);
        final int hashCode = publicAddress.hashCode();
        ObjectStorage.addObject(hashCode, publicAddress);
        return hashCode;
    }

    public static int fromTransferPayload(int payloadId) throws SerializationException {
        TransferPayload transferPayload = (TransferPayload) ObjectStorage.objectForKey(payloadId);
        PrintableWrapper printableWrapper = PrintableWrapper.fromTransferPayload(transferPayload);
        final int hashCode = printableWrapper.hashCode();
        ObjectStorage.addObject(hashCode, printableWrapper);
        return hashCode;
    }

    public static boolean hasTransferPayload(int wrapperId) {
        PrintableWrapper printableWrapper = (PrintableWrapper) ObjectStorage.objectForKey(wrapperId);
        return printableWrapper.hasTransferPayload();
    }

    public static int getTransferPayload(int wrapperId) {
        PrintableWrapper printableWrapper = (PrintableWrapper) ObjectStorage.objectForKey(wrapperId);
        TransferPayload transferPayload = printableWrapper.getTransferPayload();
        Objects.requireNonNull(transferPayload);
        final int hashCode = transferPayload.hashCode();
        ObjectStorage.addObject(hashCode, transferPayload);
        return hashCode;
    }

    public static int fromPaymentRequest(int paymentRequestId) throws SerializationException {
        PaymentRequest paymentRequest = (PaymentRequest) ObjectStorage.objectForKey(paymentRequestId);
        PrintableWrapper printableWrapper = PrintableWrapper.fromPaymentRequest(paymentRequest);
        final int hashCode = printableWrapper.hashCode();
        ObjectStorage.addObject(hashCode, printableWrapper);
        return hashCode;
    }
    public static boolean hasPaymentRequest(int wrapperId) {
        PrintableWrapper printableWrapper = (PrintableWrapper) ObjectStorage.objectForKey(wrapperId);
        return printableWrapper.hasPaymentRequest();
    }

    public static int getPaymentRequest(int wrapperId) {
        PrintableWrapper printableWrapper = (PrintableWrapper) ObjectStorage.objectForKey(wrapperId);
        PaymentRequest paymentRequest = printableWrapper.getPaymentRequest();
        Objects.requireNonNull(paymentRequest);
        final int hashCode = paymentRequest.hashCode();
        ObjectStorage.addObject(hashCode, paymentRequest);
        return hashCode;
    }
}
