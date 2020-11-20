// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SimpleKeyboard",
    //to be fair, watchOS support is pretty stupid, if you need it please open an issue...
    platforms: [.iOS(SupportedPlatform.IOSVersion.v13), .macOS(SupportedPlatform.MacOSVersion.v10_15)],
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "SimpleKeyboard",
            targets: ["SimpleKeyboard"])
    ],
    dependencies: [
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        // Targets can depend on other targets.
        .target(
            name: "SimpleKeyboard",
            dependencies: []),
        .testTarget(
            name: "SimpleKeyboardTests",
            dependencies: ["SimpleKeyboard"])
    ]
)
