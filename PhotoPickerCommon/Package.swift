// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PhotoPickerCommon",
    platforms: [.macOS(.v13), .macCatalyst(.v16)],
    products: [
        .library(
            name: "PhotoPickerCommon",
            targets: ["PhotoPickerCommon"]
        )
    ],
    targets: [
        .target(
            name: "PhotoPickerCommon",
            dependencies: []
        )
    ]
)
