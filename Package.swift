// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "DeviceInfo",
    platforms: [.iOS(.v14), .macOS(.v11), .tvOS(.v14), .watchOS(.v7), .macCatalyst(.v14)],
    products: [
        .library(
            name: "DeviceInfo",
            targets: ["DeviceInfo"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "DeviceInfo",
            dependencies: []),
        .testTarget(
            name: "DeviceInfoTests",
            dependencies: ["DeviceInfo"]),
    ]
)
