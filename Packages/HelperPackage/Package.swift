// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "HelperPackage",
  defaultLocalization: "en",
  platforms: [
    .iOS(.v16),
    .macOS(.v13),
  ],
  products: [
    .library(name: "AnalyticsReducer", targets: ["AnalyticsReducer"]),
    .library(name: "SwiftUIHelpers", targets: ["SwiftUIHelpers"]),
    .library(name: "PlaceholderAsyncImage", targets: ["PlaceholderAsyncImage"]),
  ],
  dependencies: [
    .package(path: "../ClientPackage"),
    .package(url: "https://github.com/pointfreeco/swift-composable-architecture", from: "0.54.0"),
  ],
  targets: [
    .target(name: "AnalyticsReducer", dependencies: [
      .product(name: "AnalyticsClient", package: "ClientPackage"),
      .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
    ]),
    .target(name: "SwiftUIHelpers"),
    .target(name: "PlaceholderAsyncImage"),
  ]
)
