// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ACRealm",
    platforms: [
        .iOS(.v11)
    ],
    products: [
        .library(
            name: "ACRealm",
            targets: ["ACRealm"]),
    ],
    dependencies: [
        .package(name: "Realm",
                 url: "https://github.com/realm/realm-swift",
                 .exact("10.22.0"))
    ],
    targets: [
        .target(
            name: "ACRealm",
            dependencies: [
                .product(name: "RealmSwift", package: "Realm")
            ],
            path: "Sources")
    ]
)
