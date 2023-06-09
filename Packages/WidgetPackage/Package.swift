// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "WidgetPackage",
  platforms: [
    .iOS(.v16),
    .macOS(.v13),
  ],
  products: [
    .library(name: "WidgetProtocol", targets: ["WidgetProtocol"]),
    .library(name: "WidgetHelpers", targets: ["WidgetHelpers"]),
    .library(name: "BalanceWidget", targets: ["BalanceWidget"]),
    .library(name: "VoteWidget", targets: ["VoteWidget"]),
    .library(name: "GasPriceWidget", targets: ["GasPriceWidget"]),
    .library(name: "POAPWidget", targets: ["POAPWidget"]),
    .library(name: "SnapshotSpaceWidget", targets: ["SnapshotSpaceWidget"]),
    .library(name: "MirrorWidget", targets: ["MirrorWidget"]),
    .library(name: "WidgetModule", targets: [
      "BalanceWidget",
      "VoteWidget",
      "GasPriceWidget",
      "POAPWidget",
      "SnapshotSpaceWidget",
      "MirrorWidget",
    ]),
  ],
  dependencies: [
    .package(path: "../ClientPackage"),
  ],
  targets: [
    .target(name: "WidgetProtocol"),
    .target(name: "WidgetHelpers"),
    .target(name: "BalanceWidget", dependencies: [
      "WidgetHelpers",
      "WidgetProtocol",
      .product(name: "QuickNodeClient", package: "ClientPackage"),
      .product(name: "UserDefaultsClient", package: "ClientPackage"),
    ]),
    .target(name: "VoteWidget", dependencies: [
      "WidgetHelpers",
      "WidgetProtocol",
      .product(name: "UserDefaultsClient", package: "ClientPackage"),
      .product(name: "SnapshotClient", package: "ClientPackage"),
    ]),
    .target(name: "GasPriceWidget", dependencies: [
      "WidgetHelpers",
      "WidgetProtocol",
      .product(name: "UserDefaultsClient", package: "ClientPackage"),
    ]),
    .target(name: "POAPWidget", dependencies: [
      "WidgetHelpers",
      "WidgetProtocol",
      .product(name: "POAPClient", package: "ClientPackage"),
      .product(name: "UserDefaultsClient", package: "ClientPackage"),
    ]),
    .target(name: "SnapshotSpaceWidget", dependencies: [
      "WidgetHelpers",
      "WidgetProtocol",
    ]),
    .target(name: "MirrorWidget", dependencies: [
      "WidgetHelpers",
      "WidgetProtocol",
    ]),
  ]
)
