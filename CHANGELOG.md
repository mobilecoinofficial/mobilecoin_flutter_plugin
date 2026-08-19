## 0.0.5

- `MistysignAttestedSession` now works on Android as well as iOS. `create()` throws `UnsupportedError` only on platforms other than those two.
- Native failures that declare a `ChannelErrorCode` now reach Dart under that code rather than the catch-all `NATIVE`, so Android surfaces the same `MistysignAttestedSessionErrorCode` values as iOS.
- `MistysignAttestedSession.authBeginRequestData` now throws `ArgumentError` on an empty `responderId`. The iOS SDK treats the native handshake as infallible and traps the process on one, where Android reports an invalid uri.

## 0.0.4

- Add `ios/mobilecoin_flutter/Package.swift`. The iOS side now builds through Swift Package Manager or CocoaPods, both from the same source tree.
- The iOS plugin now registers directly from `SwiftMobileCoinPlugin`; the `MobileCoinFlutterPlugin` Objective-C trampoline is gone and the sources moved to `ios/mobilecoin_flutter/Sources/mobilecoin_flutter/`. Consuming apps need a clean pod install.
- Raise the iOS dependency to `MobileCoin/CoreHTTP ~> 6.0.6`, which floats SwiftProtobuf to 1.38 and up. Those versions emit `nonisolated extension`, so a consumer on a pre-Swift-6.1 toolchain has to pin `SwiftProtobuf` to 1.29.0 in its own Podfile.

## 0.0.3

- Add `MistysignAttestedSession`, an iOS-only bridge to the Mistysign attested channel. Throws `UnsupportedError` on Android.

## 0.0.2

## Breaking Changes

- `receiptId` is no longer being returned from `sendFunds`. It has been moved to the response from `createPendingTransaction`

## 0.0.1

* Initial open source release.
