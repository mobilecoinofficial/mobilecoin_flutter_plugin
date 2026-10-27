// swift-tools-version:5.9
// Copyright (c) 2021-2026 MobileCoin. All rights reserved.

// The Flutter module comes from the host app's generated Swift package, so these sources compile
// only inside a Flutter iOS build and never under a standalone `swift build`.

import PackageDescription

let package = Package(
    name: "mobilecoin_flutter",
    platforms: [
        .iOS("15.0"),
        .macOS("11.0")
    ],
    products: [
        .library(name: "mobilecoin-flutter", targets: ["mobilecoin_flutter"])
    ],
    dependencies: [
        // 7.1.0 is the release that lets a requester carry its own timeouts, which the
        // client built below relies on. The floor moves rather than just the lock, so that
        // a consumer holding a 7.0.x lock is made to resolve forward instead of failing to
        // compile. (7.0.0 was the floor before this, as the release that removes Mistyswap,
        // which these sources no longer name.)
        .package(
            url: "https://github.com/mobilecoinofficial/MobileCoin-Swift.git",
            from: "7.1.0"
        )
    ],
    targets: [
        .target(
            name: "mobilecoin_flutter",
            dependencies: [
                .product(name: "MobileCoinCore", package: "MobileCoin-Swift")
            ]
        )
    ]
)
