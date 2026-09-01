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
        .package(
            url: "https://github.com/mobilecoinofficial/MobileCoin-Swift.git",
            exact: "6.0.7"
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
