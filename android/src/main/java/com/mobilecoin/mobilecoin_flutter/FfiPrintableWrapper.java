package com.mobilecoin.mobilecoin_flutter;

import com.mobilecoin.lib.PrintableWrapper;
import com.mobilecoin.lib.TransferPayload;
import com.mobilecoin.lib.PublicAddress;
import com.mobilecoin.lib.exceptions.SerializationException;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel.Result;
import androidx.annotation.Keep;

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
        Integer hashCode = printableWrapper.hashCode();
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
        final int hashCode = publicAddress.hashCode();
        ObjectStorage.addObject(hashCode, publicAddress);
        return hashCode;
    }

    public static int fromTransferPayload(int payloadId) throws SerializationException {
        TransferPayload transferPayload = (TransferPayload) ObjectStorage.objectForKey(payloadId);
        PrintableWrapper printableWrapper = PrintableWrapper.fromTransferPayload(transferPayload);
        Integer hashCode = printableWrapper.hashCode();
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
        final int hashCode = transferPayload.hashCode();
        ObjectStorage.addObject(hashCode, transferPayload);
        return hashCode;
    }
}
