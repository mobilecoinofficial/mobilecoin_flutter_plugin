// Copyright (c) 2021-2026 MobileCoin. All rights reserved.

package com.mobilecoin.mobilecoin_flutter;

import androidx.annotation.NonNull;

/**
 * Implemented by exceptions that carry their own Dart-side error code.
 * <p>
 * {@link Ffi#processError} reports every other failure as <code>NATIVE</code>,
 * which leaves Dart matching on message strings to tell failures apart.
 * Implement this where callers are expected to branch on the kind of failure.
 */
public interface ChannelErrorCode {

    /**
     * The code reported as {@code PlatformException.code} on the Dart side.
     */
    @NonNull
    String channelErrorCode();

}
