package com.mobilecoin.mobilecoin_flutter;

import android.os.Handler;
import android.os.Looper;

import io.flutter.plugin.common.MethodChannel.Result;

class Ffi {

    private Ffi() {
    }

    static void processSuccess(final Result result, final Object value) {
        final Handler handler = new Handler(Looper.getMainLooper());
        handler.post(new Runnable() {
            @Override
            public void run() {
                result.success(value);
            }
        });
    }

    static void processError(final Result result, final String message, final Object details) {
        final Handler handler = new Handler(Looper.getMainLooper());
        handler.post(new Runnable() {
            @Override
            public void run() {
                // TODO: error codes?
                result.error("-1", message, details);
            }
        });
    }
}
