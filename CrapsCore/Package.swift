// swift-tools-version: 6.3

import PackageDescription

let package = Package(
    name: "CrapsCore",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "CrapsCore",
            targets: ["CrapsCore"]
        ),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "CrapsCore"
        ),
        .executableTarget(
            name: "CrapsCLI",
            dependencies: ["CrapsCore"]),
        .testTarget(
            name: "CrapsCoreTests",
            dependencies: ["CrapsCore"]
        ),
    ],

    swiftLanguageModes: [.v6]
)
