// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "HelperPackage",
  products: [
    .library(name: "AnalyticsReducer", targets: ["AnalyticsReducer"]),
    .library(name: "SwiftUIHelpers", targets: ["SwiftUIHelpers"]),
    .library(name: "PlaceholderAsyncImage", targets: ["PlaceholderAsyncImage"]),
  ],
  dependencies: [
    .package(path: "../ClientPackage"),
  ],
  targets: [
    .target(name: "AnalyticsReducer", dependencies: [
      .product(name: "AnalyticsClient", package: "ClientPackage"),
    ]),
    .target(name: "SwiftUIHelpers"),
    .target(name: "PlaceholderAsyncImage"),
  ]
)
