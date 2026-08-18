## 0.0.4

- Add `ios/mobilecoin_flutter/Package.swift`. The iOS side now builds through Swift Package Manager or CocoaPods, both from the same source tree.

## 0.0.3

- Add `MistysignAttestedSession`, an iOS-only bridge to the Mistysign attested channel. Throws `UnsupportedError` on Android.

## 0.0.2

## Breaking Changes

- `receiptId` is no longer being returned from `sendFunds`. It has been moved to the response from `createPendingTransaction`

## 0.0.1

* Initial open source release.
