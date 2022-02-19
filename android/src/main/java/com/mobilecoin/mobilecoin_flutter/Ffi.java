package com.mobilecoin.mobilecoin_flutter;

import android.os.Handler;
import android.os.Looper;

import io.flutter.plugin.common.MethodChannel.Result;

class Ffi {

    private Ffi() {
    }

    static void processSuccess(final Result result, final Object value) {
        final Handler handler = new Handler(Looper.getMainLooper());
        handler.post(() -> result.success(value));
    }

    static void processError(final Result result, final String message, final Object details) {
        final Handler handler = new Handler(Looper.getMainLooper());
        handler.post(() -> result.error("NATIVE", message, details));
    }
}
