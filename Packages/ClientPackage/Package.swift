// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "ClientPackage",
  defaultLocalization: "en",
  platforms: [
    .iOS(.v16),
  ],
  products: [
    .library(name: "UIApplicationClient", targets: ["UIApplicationClient"]),
    .library(name: "SnapshotClient", targets: ["SnapshotClient"]),
    .library(name: "ServerConfig", targets: ["ServerConfig"]),
    .library(name: "GitHubClient", targets: ["GitHubClient"]),
    .library(name: "UserDefaultsClient", targets: ["UserDefaultsClient"]),
    .library(name: "QuickNodeClient", targets: ["QuickNodeClient"]),
    .library(name: "POAPClient", targets: ["POAPClient"]),
    .library(name: "WidgetClient", targets: ["WidgetClient"]),
    .library(name: "AuthClient", targets: ["AuthClient"]),
    .library(name: "SnapshotModel", targets: ["SnapshotModel"]),
    .library(name: "SnapshotModelMock", targets: ["SnapshotModelMock"]),
    .library(name: "ApolloHelpers", targets: ["ApolloHelpers"]),
  ],
  dependencies: [
    .package(url: "https://github.com/pointfreeco/swift-composable-architecture", from: "0.54.0"),
    .package(url: "https://github.com/apollographql/apollo-ios", from: "1.1.2"),
  ],
  targets: [
    .target(name: "UIApplicationClient", dependencies: [
      .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
    ]),
    .target(name: "SnapshotClient", dependencies: [
      "ApolloHelpers",
      "SnapshotModel",
      .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
    ]),
    .target(name: "ServerConfig"),
    .target(name: "GitHubClient", dependencies: [
      .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
    ]),
    .target(name: "UserDefaultsClient", dependencies: [
      .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
    ]),
    .target(name: "QuickNodeClient", dependencies: [
      .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
    ]),
    .target(name: "POAPClient", dependencies: [
      .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
    ]),
    .target(name: "WidgetClient", dependencies: [
      .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
    ]),
    .target(name: "AuthClient", dependencies: [
      .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
    ]),
    .target(name: "SnapshotModel", dependencies: [
      .product(name: "ApolloAPI", package: "apollo-ios"),
    ]),
    .target(name: "SnapshotModelMock", dependencies: [
      "SnapshotModel",
      .product(name: "ApolloTestSupport", package: "apollo-ios"),
    ]),
    .target(name: "ApolloHelpers", dependencies: [
      .product(name: "Apollo", package: "apollo-ios"),
      .product(name: "ApolloAPI", package: "apollo-ios"),
    ]),
  ]
)
