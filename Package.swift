// swift-tools-version: 6.3.3

import PackageDescription

// ASCII Primitives - Tier 2
//
// ASCII character definitions and operations with Byte.Protocol conformance.
// Foundation for all ASCII-related processing across the Swift Institute packages.
//
// Per INCITS 4-1986 (R2022): 7-Bit American Standard Code for Information Interchange.
//
// ASCII.Code conforms to Byte.`Protocol` (the per-domain capability marker from
// swift-byte-primitives). This pulls swift-byte-primitives + swift-carrier-primitives
// + swift-tagged-primitives transitively, moving this package from Tier 0 to Tier 2.

let package = Package(
    name: "swift-ascii-primitives",
    platforms: [
        .macOS("27"),
        .iOS("27"),
        .tvOS("27"),
        .watchOS("27"),
        .visionOS("27"),
    ],
    products: [
        .library(
            name: "ASCII Primitives",
            targets: ["ASCII Primitives"]
        ),
        .library(
            name: "ASCII Primitives Standard Library Integration",
            targets: ["ASCII Primitives Standard Library Integration"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/swift-primitives/swift-byte-primitives.git", branch: "main"),
    ],
    targets: [
        .target(
            name: "ASCII Primitives",
            dependencies: [
                .product(name: "Byte Primitives", package: "swift-byte-primitives"),
                .product(name: "Byte Primitives Standard Library Integration", package: "swift-byte-primitives"),
            ]
        ),
        .target(
            name: "ASCII Primitives Standard Library Integration",
            dependencies: [
                "ASCII Primitives",
                .product(name: "Byte Primitives", package: "swift-byte-primitives"),
                .product(name: "Byte Primitives Standard Library Integration", package: "swift-byte-primitives"),
            ]
        ),
        .testTarget(
            name: "ASCII Primitives Tests",
            dependencies: [
                "ASCII Primitives",
                .product(name: "Byte Primitives", package: "swift-byte-primitives"),
            ]
        ),
        .testTarget(
            name: "ASCII Primitives Standard Library Integration Tests",
            dependencies: [
                "ASCII Primitives",
                "ASCII Primitives Standard Library Integration",
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
        .enableExperimentalFeature("LifetimeDependence"),
        .enableExperimentalFeature("Lifetimes"),
        .enableExperimentalFeature("SuppressedAssociatedTypes"),
        .enableUpcomingFeature("InferIsolatedConformances"),
        .enableUpcomingFeature("LifetimeDependence"),
    ]

    let package: [SwiftSetting] = []

    target.swiftSettings = (target.swiftSettings ?? []) + ecosystem + package
}
