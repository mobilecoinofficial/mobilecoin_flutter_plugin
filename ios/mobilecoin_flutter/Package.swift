// swift-tools-version:5.9
// Copyright (c) 2021-2026 MobileCoin. All rights reserved.

import PackageDescription

let package = Package(
    name: "mobilecoin_flutter",
    platforms: [
        .iOS("13.0"),
        .macOS("11.0")
    ],
    products: [
        .library(name: "mobilecoin-flutter", targets: ["mobilecoin_flutter"])
    ],
    dependencies: [
        .package(
            url: "https://github.com/mobilecoinofficial/MobileCoin-Swift.git",
            from: "6.0.6"
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
