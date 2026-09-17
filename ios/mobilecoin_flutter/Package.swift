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
        // 7.0.0 is the release that removes Mistyswap, so it is the first version the
        // sources here can resolve now that they no longer name it. The floor moves rather
        // than just the lock, because a 6.x floor will not resolve a 7.x major on its own.
        .package(
            url: "https://github.com/mobilecoinofficial/MobileCoin-Swift.git",
            from: "7.0.0"
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
