// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.
import PackageDescription

let package = Package(
    name: "SwiftMinions",
    platforms: [
        .iOS(SupportedPlatform.IOSVersion.v10)
        // .macOS(.v10_13), .iOS(.v11), .tvOS(.v11),
    ],
    products: [
        .library(name: "SwiftMinions", targets: ["SwiftMinions"])
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        .target(name: "SwiftMinions", dependencies: [])
    ]
)