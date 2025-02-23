// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "SwiftUIFlutterLikeForm",
    platforms: [
        .iOS(.v16),
    ],
    version: "0.1.0"
    products: [
        .library(
            name: "FlutterLikeForm",
            targets: ["FlutterLikeForm"]
        ),
    ],
    targets: [
        .target(
            name: "FlutterLikeForm",
            dependencies: [],
            path: "Sources/FlutterLikeForm"
        ),
        .testTarget(
            name: "FlutterLikeFormTests",
            dependencies: ["FlutterLikeForm"],
            path: "Tests/FlutterLikeFormTests"
        ),
    ]
)
