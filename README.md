# mobilecoin_flutter

[![build_status][]][builds]

The mobilecoin_flutter plugin makes the iOS and Android MobileCoin SDKs available to Flutter apps.

[build_status]: https://github.com/mobilecoinofficial/mobilecoin_flutter_plugin/actions/workflows/main.yaml/badge.svg
[builds]: https://github.com/mobilecoinofficial/mobilecoin_flutter_plugin/actions/workflows/main.yaml

Please see [CONTRIBUTING.md](CONTRIBUTING.md) for notes on contributing bug reports and code, and [TERMS-OF-USE.md](TERMS-OF-USE.md) for terms of use.

## Build iOS

```bash
$ cd example; flutter build ios --simulator
```

Swift Package Manager is the only iOS route, and `flutter build ios-framework`
forces CocoaPods. That command skips this plugin and writes a framework set with
no `mobilecoin_flutter.xcframework`. It also puts the CocoaPods integration back
under `example/ios`: a `Podfile`, a `Podfile.lock`, a `Pods` directory, and
rewrites of the tracked Xcode project, workspace and Flutter xcconfigs. Restore
`example/ios` afterwards, and delete the untracked `Podfile` and `Podfile.lock`
with it. A device build needs `flutter build ios --no-codesign`, because the
project carries no `DEVELOPMENT_TEAM`.

## Generating Protobufs

```bash
$ ./bin/update_protobufs.sh
```

