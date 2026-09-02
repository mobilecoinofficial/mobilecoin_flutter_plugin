## 0.0.7

- The SwiftPM floor for `MobileCoin-Swift` is now 6.1.0. Every 6.0.x tag vendors `libmobilecoin` as a submodule whose gitlink the reseeded repository no longer serves, so SwiftPM fails the checkout. The CocoaPods dependency stays at `MobileCoin/CoreHTTP ~> 6.0.6` because CocoaPods trunk publishes no 6.1.0 podspec. The pod source is the same git tag with submodules, so the pod route needs a warm cache until 6.1.0 is published.

## 0.0.6

- iOS now emits `blockCount` in the account activity JSON as a number rather than a quoted string, matching what Android has always sent. A consumer that parsed the iOS value as a `String` needs to read it as an `int`.

## 0.0.5

- The iOS deployment target is now 15.0, up from 12.2. Flutter 3.41 requires 13.0 of its own, and the Sentz app already builds at 15.0.
- `MistysignAttestedSession` now works on Android as well as iOS. `create()` throws `UnsupportedError` only on platforms other than those two.
- Native failures that declare a `ChannelErrorCode` now reach Dart under that code rather than the catch-all `NATIVE`, so Android surfaces the same `MistysignAttestedSessionErrorCode` values as iOS.
- `MistysignAttestedSession.authBeginRequestData` now throws `ArgumentError` on an empty `responderId`, and the iOS plugin rejects one as well. The iOS SDK treats the native handshake as infallible and traps the process on one, where Android reports an invalid uri.
- Add `MistysignAttestedSessionErrorCode.invalidTrustedIdentity`, raised when a trusted identity cannot be read. Previously this shared `attestationFailed` with an enclave whose evidence did not match, so a local configuration fault and a real attestation failure were indistinguishable. Callers matching on `attestationFailed` to detect a bad identity need to match the new code instead.

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
