// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "mobilecoin_flutter",
    platforms: [
        .iOS("13.0"),
    ],
    products: [
//        .library(name: "mobilecoin-flutter", targets: ["mobilecoin_flutter", "mobilecoin_flutter_objc"])
        .library(name: "mobilecoin-flutter", targets: ["mobilecoin_flutter"])
    ],
    dependencies: [
        .package(
            url: "https://github.com/mobilecoinofficial/MobileCoin-Swift",
            from: "6.0.4"
        ),
    ],
    targets: [
        .target(
            name: "mobilecoin_flutter",
            dependencies: [.product(name: "MobileCoinCore", package: "MobileCoin-Swift")],
            resources: [],
            swiftSettings: [.define("PLATFORM_IOS_13", .when(platforms: [.iOS], configuration: .release))]
        ),
//        .target(
//            name: "mobilecoin_flutter_objc",
//            dependencies: [.product(name: "MobileCoinCore", package: "MobileCoin-Swift")],
//            resources: [],
//            cSettings: [.headerSearchPath("include/mobilecoin_flutter")],
//            swiftSettings: [.define("PLATFORM_IOS_13", .when(platforms: [.iOS], configuration: .release))]
//        )
    ]
)
