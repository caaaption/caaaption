// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

var package = Package(
  name: "FeaturePackage",
  defaultLocalization: "en",
  platforms: [
    .iOS(.v16),
    .macOS(.v13),
  ],
  products: [
    .library(name: "AppFeature", targets: ["AppFeature"]),
    .library(name: "WidgetSearchFeature", targets: ["WidgetSearchFeature"]),
    .library(name: "AccountFeature", targets: ["AccountFeature"]),
    .library(name: "ContributorFeature", targets: ["ContributorFeature"]),
    .library(name: "BalanceWidgetFeature", targets: ["BalanceWidgetFeature"]),
    .library(name: "VoteWidgetFeature", targets: ["VoteWidgetFeature"]),
    .library(name: "OnboardFeature", targets: ["OnboardFeature"]),
    .library(name: "POAPWidgetFeature", targets: ["POAPWidgetFeature"]),
    .library(name: "GasPriceWidgetFeature", targets: ["GasPriceWidgetFeature"]),
    .library(name: "WidgetTabFeature", targets: ["WidgetTabFeature"]),
    .library(name: "LinkFeature", targets: ["LinkFeature"]),
    .library(name: "GalleryFeature", targets: ["GalleryFeature"]),
  ],
  dependencies: [
    .package(path: "../HelperPackage"),
    .package(path: "../WidgetPackage"),
    .package(path: "../ClientPackage"),
    .package(path: "../GraphQLPackage"),
    .package(url: "https://github.com/pointfreeco/swift-composable-architecture", from: "0.54.0"),
    .package(url: "https://github.com/apollographql/apollo-ios", from: "1.2.2"),
    .package(url: "https://github.com/onevcat/Kingfisher", from: "7.8.1"),
  ],
  targets: [
    .target(name: "AppFeature", dependencies: [
      "WidgetTabFeature",
      "OnboardFeature",
      .product(name: "ServerConfigClient", package: "ClientPackage"),
    ]),
    .target(name: "WidgetSearchFeature", dependencies: [
      "VoteWidgetFeature",
      "POAPWidgetFeature",
      "BalanceWidgetFeature",
      "GasPriceWidgetFeature",
      .product(name: "AnalyticsReducer", package: "HelperPackage"),
    ]),
    .target(name: "WidgetListFeature", dependencies: [
      "VoteWidgetFeature",
      "POAPWidgetFeature",
      "BalanceWidgetFeature",
      "GasPriceWidgetFeature",
    ]),
    .target(name: "AccountFeature", dependencies: [
      "LinkFeature",
      "ContributorFeature",
    ]),
    .target(name: "ContributorFeature", dependencies: [
      .product(name: "GitHubClient", package: "ClientPackage"),
      .product(name: "SwiftUIHelpers", package: "HelperPackage"),
      .product(name: "PlaceholderAsyncImage", package: "HelperPackage"),
      .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
    ]),
    .target(name: "BalanceWidgetFeature", dependencies: [
      .product(name: "SwiftUIHelpers", package: "HelperPackage"),
      .product(name: "WidgetClient", package: "ClientPackage"),
      .product(name: "BalanceWidget", package: "WidgetPackage"),
      .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
    ]),
    .target(name: "VoteWidgetFeature", dependencies: [
      .product(name: "SwiftUIHelpers", package: "HelperPackage"),
      .product(name: "VoteWidget", package: "WidgetPackage"),
      .product(name: "WidgetClient", package: "ClientPackage"),
      .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
    ]),
    .target(name: "OnboardFeature", dependencies: [
      .product(name: "SwiftUIHelpers", package: "HelperPackage"),
      .product(name: "AuthClient", package: "ClientPackage"),
      .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
    ]),
    .target(name: "POAPWidgetFeature", dependencies: [
      .product(name: "SwiftUIHelpers", package: "HelperPackage"),
      .product(name: "Kingfisher", package: "Kingfisher"),
      .product(name: "POAPWidget", package: "WidgetPackage"),
      .product(name: "POAPClient", package: "ClientPackage"),
      .product(name: "WidgetClient", package: "ClientPackage"),
      .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
    ]),
    .target(name: "GasPriceWidgetFeature", dependencies: [
      .product(name: "SwiftUIHelpers", package: "HelperPackage"),
      .product(name: "GasPriceWidget", package: "WidgetPackage"),
      .product(name: "WidgetClient", package: "ClientPackage"),
      .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
    ]),
    .target(name: "WidgetTabFeature", dependencies: [
      "LinkFeature",
      "AccountFeature",
      "ContributorFeature",
      "WidgetSearchFeature",
    ]),
    .target(name: "LinkFeature", dependencies: [
      .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
    ]),
    .target(name: "GalleryFeature", dependencies: [
      .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
    ]),
  ]
)
