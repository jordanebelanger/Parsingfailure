// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Parsefail",
    products: [],
    dependencies: [
        .package(url: "https://github.com/fabianfett/pure-swift-json.git", .branch("master")),
        .package(url: "https://github.com/skelpo/JSON.git", .branch("master")),
        .package(url: "https://github.com/Ikiga/IkigaJSON.git", from: "2.0.0"),
    ],
    targets: [
        .target(
            name: "Parsefail",
            dependencies: [
                .product(name: "IkigaJSON", package: "IkigaJSON"),
                .product(name: "PureSwiftJSON", package: "pure-swift-json"),
                .product(name: "JSON", package: "JSON"),
            ])
    ]
)
