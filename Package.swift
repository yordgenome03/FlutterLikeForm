// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "SwiftUIFormPackage",
    platforms: [
        .iOS(.v16),
    ],
    products: [
        .library(
            name: "SwiftUIFormPackage",
            targets: ["SwiftUIFormPackage"]
        ),
    ],
    targets: [
        .target(
            name: "SwiftUIFormPackage",
            dependencies: [],
            path: "Sources/SwiftUIFormPackage"
        ),
        .testTarget(
            name: "SwiftUIFormPackageTests",
            dependencies: ["SwiftUIFormPackage"],
            path: "Tests/SwiftUIFormPackageTests"
        ),
    ]
)
