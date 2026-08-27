// swift-tools-version: 6.4

import PackageDescription

let package = Package(
    name: "swift-ascii",
    platforms: [
        .macOS(.v27),
        .iOS(.v27),
        .tvOS(.v27),
        .watchOS(.v27),
        .visionOS(.v27),
    ],
    products: [
        .library(
            name: "ASCII",
            targets: ["ASCII"]
        ),
        .library(
            name: "ASCII Standard Library Integration",
            targets: ["ASCII Standard Library Integration"]
        ),
        .library(
            name: "ASCII Apple Foundation Integration",
            targets: ["ASCII Apple Foundation Integration"]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "ASCII",
            dependencies: []
        ),
        .target(
            name: "ASCII Standard Library Integration",
            dependencies: ["ASCII"]
        ),
        .target(
            name: "ASCII Apple Foundation Integration",
            dependencies: [
                "ASCII",
                "ASCII Standard Library Integration",
            ]
        ),
        .testTarget(
            name: "ASCII Tests",
            dependencies: ["ASCII"]
        ),
        .testTarget(
            name: "ASCII Standard Library Integration Tests",
            dependencies: [
                "ASCII",
                "ASCII Standard Library Integration",
            ]
        ),
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets where ![.system, .binary, .plugin, .macro].contains(target.type) {
    let ecosystem: [SwiftSetting] = [
        .strictMemorySafety(),
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility"),
        .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
        .enableExperimentalFeature("Lifetimes"),
        .enableUpcomingFeature("InferIsolatedConformances"),
    ]

    let package: [SwiftSetting] = []

    target.swiftSettings = (target.swiftSettings ?? []) + ecosystem + package
}
