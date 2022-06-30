// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SimpleKeyboard",
    defaultLocalization: "en",
    // to be fair, watchOS support for this keyboard is not very useful, if you need it please open an issue...
    platforms: [.iOS(SupportedPlatform.IOSVersion.v13), .macOS(SupportedPlatform.MacOSVersion.v11)],
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "SimpleKeyboard",
            targets: ["SimpleKeyboard"])
    ],
    dependencies: [
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
