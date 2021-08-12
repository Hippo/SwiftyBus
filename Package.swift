// swift-tools-version:5.4.0

import PackageDescription

let package = Package(
    name: "SwiftyBus",
    products: [
        .library(
            name: "SwiftyBus",
            targets: ["SwiftyBus"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "SwiftyBus",
            dependencies: []),
        .testTarget(
            name: "SwiftyBusTests",
            dependencies: ["SwiftyBus"]),
    ]
)
