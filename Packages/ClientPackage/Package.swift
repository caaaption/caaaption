// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "ClientPackage",
  platforms: [
    .iOS(.v16),
    .macOS(.v13),
  ],
  products: [
    .library(name: "UIApplicationClient", targets: ["UIApplicationClient"]),
    .library(name: "SnapshotClient", targets: ["SnapshotClient"]),
    .library(name: "GitHubClient", targets: ["GitHubClient"]),
    .library(name: "UserDefaultsClient", targets: ["UserDefaultsClient"]),
    .library(name: "QuickNodeClient", targets: ["QuickNodeClient"]),
    .library(name: "POAPClient", targets: ["POAPClient"]),
    .library(name: "WidgetClient", targets: ["WidgetClient"]),
    .library(name: "AuthClient", targets: ["AuthClient"]),
  ],
  dependencies: [
    .package(path: "../GraphQLPackage"),
    .package(url: "https://github.com/pointfreeco/swift-dependencies", from: "0.5.1"),
    .package(url: "https://github.com/pointfreeco/xctest-dynamic-overlay", from: "0.8.5"),
  ],
  targets: [
    .target(name: "UIApplicationClient", dependencies: [
      .product(name: "Dependencies", package: "swift-dependencies"),
    ]),
    .target(name: "SnapshotClient", dependencies: [
      .product(name: "ApolloHelpers", package: "GraphQLPackage"),
      .product(name: "SnapshotModel", package: "GraphQLPackage"),
      .product(name: "Dependencies", package: "swift-dependencies"),
    ]),
    .target(name: "GitHubClient", dependencies: [
      .product(name: "Dependencies", package: "swift-dependencies"),
    ]),
    .target(name: "UserDefaultsClient", dependencies: [
      .product(name: "Dependencies", package: "swift-dependencies"),
    ]),
    .target(name: "QuickNodeClient", dependencies: [
      .product(name: "Dependencies", package: "swift-dependencies"),
    ]),
    .target(name: "POAPClient", dependencies: [
      .product(name: "Dependencies", package: "swift-dependencies"),
    ]),
    .target(name: "WidgetClient", dependencies: [
      .product(name: "Dependencies", package: "swift-dependencies"),
    ]),
    .target(name: "AuthClient", dependencies: [
      .product(name: "Dependencies", package: "swift-dependencies"),
    ]),
  ]
)
