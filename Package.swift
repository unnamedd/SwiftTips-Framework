// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Tips",
    products: [
        .executable(
            name: "tips",
            targets: ["Tips"]
        ),
        .library(
            name: "TipsCore",
            targets: ["TipsCore"]
        ),
    ],
    targets: [
        .target(
            name: "Tips",
            dependencies: ["TipsCore"]
        ),
        .target(name: "TipsCore"),
        .testTarget(
            name: "TipsTests",
            dependencies: ["TipsCore"]
        ),
    ]
)
