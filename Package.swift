// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "DeviceInfo",
    platforms: [.iOS(.v15), .macOS(.v12), .tvOS(.v15), .watchOS(.v8), .macCatalyst(.v15)],
    products: [
        .library(
            name: "DeviceInfo",
            targets: ["DeviceInfo"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "DeviceInfo",
            dependencies: [],
            swiftSettings: [.define("APPLICATION_EXTENSION_API_ONLY")]),
        .testTarget(
            name: "DeviceInfoTests",
            dependencies: ["DeviceInfo"]),
    ]
)
