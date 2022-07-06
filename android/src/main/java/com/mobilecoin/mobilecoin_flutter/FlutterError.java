package com.mobilecoin.mobilecoin_flutter;

import io.flutter.BuildConfig;
import io.flutter.Log;

public class FlutterError extends RuntimeException {
    private static final String TAG = "FlutterException#";

    public final String code;
    public final Object details;

    FlutterError(String code, String message, Object details) {
        super(message);
        if (BuildConfig.DEBUG && code == null) {
            Log.e(TAG, "Parameter code must not be null.");
        }
        this.code = code;
        this.details = details;
    }
}
