// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

var package = Package(
  name: "caaaption",
  defaultLocalization: "en",
  platforms: [
    .iOS(.v16),
    .macOS(.v13),
  ],
  dependencies: [
    .package(url: "https://github.com/pointfreeco/swift-composable-architecture", from: "0.54.0"),
    .package(url: "https://github.com/apollographql/apollo-ios", from: "1.2.2"),
    .package(url: "https://github.com/caaaption/design-system", branch: "main"),
    .package(path: "../ClientPackage"),
    .package(path: "../GraphQLPackage"),
  ]
)

// Features
package.products.append(contentsOf: [
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
])
package.targets.append(contentsOf: [
  .target(name: "AppFeature", dependencies: [
    "WidgetTabFeature",
    "OnboardFeature",
  ]),
  .target(name: "WidgetSearchFeature", dependencies: [
    "BalanceWidgetFeature",
    "VoteWidgetFeature",
    "POAPWidgetFeature",
    "GasPriceWidgetFeature",
  ]),
  .target(name: "AccountFeature", dependencies: [
    "ServerConfig",
    "ContributorFeature",
    .product(name: "Avatar", package: "design-system"),
  ]),
  .target(name: "ContributorFeature", dependencies: [
    "SwiftUIHelpers",
    "PlaceholderAsyncImage",
    .product(name: "GitHubClient", package: "ClientPackage"),
    .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
  ]),
  .target(name: "BalanceWidgetFeature", dependencies: [
    "BalanceWidget",
    "SwiftUIHelpers",
    .product(name: "WidgetClient", package: "ClientPackage"),
    .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
  ]),
  .target(name: "VoteWidgetFeature", dependencies: [
    "VoteWidget",
    "SwiftUIHelpers",
    .product(name: "WidgetClient", package: "ClientPackage"),
    .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
  ]),
  .target(name: "OnboardFeature", dependencies: [
    "ServerConfig",
    "SwiftUIHelpers",
    .product(name: "AuthClient", package: "ClientPackage"),
    .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
  ]),
  .target(name: "POAPWidgetFeature", dependencies: [
    "POAPWidget",
    "SwiftUIHelpers",
    .product(name: "POAPClient", package: "ClientPackage"),
    .product(name: "WidgetClient", package: "ClientPackage"),
    .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
  ]),
  .target(name: "GasPriceWidgetFeature", dependencies: [
    "SwiftUIHelpers",
    "GasPriceWidget",
    .product(name: "WidgetClient", package: "ClientPackage"),
    .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
  ]),
  .target(name: "WidgetTabFeature", dependencies: [
    "WidgetSearchFeature",
    "AccountFeature",
    .product(name: "Avatar", package: "design-system"),
  ]),
])

// Client

package.products.append(contentsOf: [
  .library(name: "ServerConfig", targets: ["ServerConfig"]),
])
package.targets.append(contentsOf: [
  .target(name: "ServerConfig"),
])

// Helpers

package.products.append(contentsOf: [
  .library(name: "SwiftUIHelpers", targets: ["SwiftUIHelpers"]),
])
package.targets.append(contentsOf: [
  .target(name: "SwiftUIHelpers"),
])

// Utilities
package.products.append(contentsOf: [
  .library(name: "PlaceholderAsyncImage", targets: ["PlaceholderAsyncImage"]),
])
package.targets.append(contentsOf: [
  .target(name: "PlaceholderAsyncImage"),
])

// Widgets

package.products.append(contentsOf: [
  .library(name: "WidgetProtocol", targets: ["WidgetProtocol"]),
  .library(name: "WidgetHelpers", targets: ["WidgetHelpers"]),
  .library(name: "WidgetModule", targets: [
    "BalanceWidget",
    "VoteWidget",
    "GasPriceWidget",
    "POAPWidget",
    "SnapshotSpaceWidget",
    "MirrorWidget",
  ]),
  .library(name: "BalanceWidget", targets: ["BalanceWidget"]),
  .library(name: "VoteWidget", targets: ["VoteWidget"]),
  .library(name: "GasPriceWidget", targets: ["GasPriceWidget"]),
  .library(name: "POAPWidget", targets: ["POAPWidget"]),
  .library(name: "SnapshotSpaceWidget", targets: ["SnapshotSpaceWidget"]),
  .library(name: "MirrorWidget", targets: ["MirrorWidget"]),
])
package.targets.append(contentsOf: [
  .target(name: "WidgetProtocol"),
  .target(name: "WidgetHelpers"),
  .target(name: "BalanceWidget", dependencies: [
    "WidgetHelpers",
    "WidgetProtocol",
    .product(name: "QuickNodeClient", package: "ClientPackage"),
    .product(name: "UserDefaultsClient", package: "ClientPackage"),
    .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
  ]),
  .target(name: "VoteWidget", dependencies: [
    "WidgetHelpers",
    "WidgetProtocol",
    .product(name: "SnapshotClient", package: "ClientPackage"),
    .product(name: "UserDefaultsClient", package: "ClientPackage"),
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
])
