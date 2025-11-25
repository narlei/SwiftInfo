// swift-tools-version:6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.
// This package is designed for Swift 6.2+

import PackageDescription

let package = Package(
    name: "SwiftInfo",
    platforms: [
        .macOS(.v13)
    ],
    products: [
        .library(name: "SwiftInfoCore", type: .dynamic, targets: ["SwiftInfoCore"]),
        .executable(name: "swiftinfo", targets: ["SwiftInfo"])
    ],
    dependencies: [
        .package(url: "https://github.com/tuist/xcodeproj.git", from: "8.23.0"),
        .package(url: "https://github.com/apple/swift-argument-parser", from: "1.5.0"),
    ],
    targets: [
        // Csourcekitd: C modules wrapper for sourcekitd.
        .target(
            name: "Csourcekitd",
            dependencies: [],
            swiftSettings: [
                .enableUpcomingFeature("StrictConcurrency")
            ]),
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "SwiftInfoCore",
            dependencies: [
                "Csourcekitd", 
                .product(name: "XcodeProj", package: "xcodeproj")
            ],
            swiftSettings: [
                .enableUpcomingFeature("StrictConcurrency")
            ]),
        .executableTarget(
            name: "SwiftInfo",
            dependencies: [
                "SwiftInfoCore", 
                .product(name: "ArgumentParser", package: "swift-argument-parser")
            ],
            swiftSettings: [
                .enableUpcomingFeature("StrictConcurrency")
            ]),
        .testTarget(
            name: "SwiftInfoTests",
            dependencies: ["SwiftInfo"],
            swiftSettings: [
                .enableUpcomingFeature("StrictConcurrency")
            ]),
    ]
)
