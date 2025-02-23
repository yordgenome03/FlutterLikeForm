// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "SwiftUIFlutterForm",
    platforms: [
        .iOS(.v16),
    ],
    products: [
        .library(
            name: "SwiftUIFlutterForm",
            targets: ["SwiftUIFlutterForm"]
        ),
    ],
    targets: [
        .target(
            name: "SwiftUIFlutterForm",
            dependencies: [],
            path: "Sources/SwiftUIFlutterForm"
        ),
        .testTarget(
            name: "SwiftUIFlutterFormTests",
            dependencies: ["SwiftUIFlutterForm"],
            path: "Tests/SwiftUIFlutterFormTests"
        ),
    ]
)

