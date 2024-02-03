// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DesignSystem",
    platforms: [.iOS(.v17)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "DesignSystem",
            targets: ["DesignSystem", "SwiftUIElements", "UIKitElements"]),
    ],
    targets: [
        .target(
            name: "DesignSystem",
            dependencies: ["Extensions"]
        ),
        .target(
            name: "Extensions",
            dependencies: []
        ),
        .target(
            name: "SwiftUIElements",
            dependencies: ["Extensions", "DesignSystem"],
            path: "Sources/SwiftUIElements"
        ),
        .target(
            name: "UIKitElements",
            dependencies: ["Extensions", "DesignSystem"],
            path: "Sources/UIKitElements"
        ),
    ]
)
