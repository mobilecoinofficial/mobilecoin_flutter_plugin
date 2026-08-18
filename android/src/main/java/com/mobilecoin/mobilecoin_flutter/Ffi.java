// Copyright (c) 2021-2024 MobileCoin. All rights reserved.

package com.mobilecoin.mobilecoin_flutter;

import android.os.Handler;
import android.os.Looper;

import io.flutter.plugin.common.MethodChannel.Result;

class Ffi {

    /** Reported for any failure that does not declare a {@link ChannelErrorCode}. */
    private static final String DEFAULT_ERROR_CODE = "NATIVE";

    private Ffi() {
    }

    static void processSuccess(final Result result, final Object value) {
        final Handler handler = new Handler(Looper.getMainLooper());
        handler.post(() -> result.success(value));
    }

    static void processError(final Result result, final String message, final Object details) {
        processError(result, DEFAULT_ERROR_CODE, message, details);
    }

    /**
     * Reports a failure under <code>code</code>, which reaches Dart as
     * {@code PlatformException.code}. Prefer {@link #errorCodeFor} over
     * hand-picking a code so that the mapping stays with the exception.
     */
    static void processError(final Result result, final String code, final String message,
                             final Object details) {
        final Handler handler = new Handler(Looper.getMainLooper());
        handler.post(() -> result.error(code, message, details));
    }

    /**
     * The Dart-side code for <code>throwable</code>: its own when it declares
     * one via {@link ChannelErrorCode}, and the catch-all otherwise.
     */
    static String errorCodeFor(final Throwable throwable) {
        return throwable instanceof ChannelErrorCode
                ? ((ChannelErrorCode) throwable).channelErrorCode()
                : DEFAULT_ERROR_CODE;
    }
}
