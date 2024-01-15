// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "LinkyAPI",
    platforms: [
       .iOS(.v16)
     ],
    products: [
        .library(
            name: "LinkyAPI",
            targets: ["LinkyAPI"]),
    ],
    targets: [
        .target(
            name: "LinkyAPI"),
        .testTarget(
            name: "LinkyAPITests",
            dependencies: ["LinkyAPI"]),
    ]
)
