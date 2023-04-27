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
    .package(url: "https://github.com/pointfreeco/swift-composable-architecture", from: "0.51.0"),
    .package(url: "https://github.com/marmelroy/PhoneNumberKit", from: "3.4.0"),
    .package(url: "https://github.com/JWAutumn/ACarousel", from: "0.2.0"),
    .package(url: "https://github.com/apollographql/apollo-ios", from: "1.1.2"),
  ]
)

// Features
package.products.append(contentsOf: [
  .library(name: "AppFeature", targets: ["AppFeature"]),
  .library(name: "MainTabFeature", targets: ["MainTabFeature"]),
  .library(name: "ContentFeature", targets: ["ContentFeature"]),
  .library(name: "OnboardFeature", targets: ["OnboardFeature"]),
  .library(name: "FeedFeature", targets: ["FeedFeature"]),
  .library(name: "UploadFeature", targets: ["UploadFeature"]),
  .library(name: "ProfileFeature", targets: ["ProfileFeature"]),
  .library(name: "CollectionFeature", targets: ["CollectionFeature"]),
  .library(name: "WidgetSearchFeature", targets: ["WidgetSearchFeature"]),
])
package.targets.append(contentsOf: [
  .target(name: "AppFeature", dependencies: [
    "WidgetSearchFeature",
  ]),
  .target(name: "MainTabFeature", dependencies: [
    "FeedFeature",
    "UploadFeature",
    "ProfileFeature",
  ]),
  .target(name: "ContentFeature", dependencies: [
    "SwiftUIHelpers",
    "OffsetObservingScrollView",
    .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
  ]),
  .target(name: "OnboardFeature", dependencies: [
    "DesignSystem",
    "SwiftUIHelpers",
    "PhoneNumberClient",
    .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
  ]),
  .target(name: "FeedFeature", dependencies: [
    "ACarousel",
    "ContentFeature",
  ]),
  .target(name: "UploadFeature", dependencies: [
    "ColorHex",
    "SwiftUIHelpers",
    "PhotoLibraryClient",
    "AVFoundationClient",
    .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
  ]),
  .target(name: "ProfileFeature", dependencies: [
    "SwiftUIHelpers",
    "CollectionFeature"
  ]),
  .target(name: "CollectionFeature", dependencies: [
    .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
  ]),
  .target(name: "WidgetSearchFeature", dependencies: [
    "SwiftUIHelpers",
    .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
  ]),
])

// UI

package.products.append(contentsOf: [
  .library(name: "DesignSystem", targets: ["DesignSystem"]),
  .library(name: "Styleguide", targets: ["Styleguide"]),
  .library(name: "OffsetObservingScrollView", targets: ["OffsetObservingScrollView"]),
])
package.targets.append(contentsOf: [
  .target(name: "DesignSystem"),
  .target(name: "Styleguide"),
  .target(name: "OffsetObservingScrollView"),
])

// Model
package.products.append(contentsOf: [
  .library(name: "SnapshotModel", targets: ["SnapshotModel"]),
  .library(name: "SnapshotModelMock", targets: ["SnapshotModelMock"]),
])
package.targets.append(contentsOf: [
  .target(name: "SnapshotModel", dependencies: [
    .product(name: "ApolloAPI", package: "apollo-ios"),
  ]),
  .target(name: "SnapshotModelMock", dependencies: [
    "SnapshotModel",
    .product(name: "ApolloTestSupport", package: "apollo-ios"),
  ]),
])

// Client

package.products.append(contentsOf: [
  .library(name: "AVFoundationClient", targets: ["AVFoundationClient"]),
  .library(name: "FirebaseClientLive", targets: ["FirebaseClientLive"]),
  .library(name: "PhoneNumberClient", targets: ["PhoneNumberClient"]),
  .library(name: "PhotoLibraryClientLive", targets: ["PhotoLibraryClientLive"]),
  .library(name: "UserNotificationClient", targets: ["UserNotificationClient"]),
  .library(name: "UIApplicationClient", targets: ["UIApplicationClient"]),
  .library(name: "SnapshotClient", targets: ["SnapshotClient"]),
])
package.targets.append(contentsOf: [
  .target(name: "AVFoundationClient", dependencies: [
    .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
  ]),
  .target(name: "FirebaseClient", dependencies: [
    .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
  ]),
  .target(name: "FirebaseClientLive", dependencies: [
    "FirebaseClient",
  ]),
  .target(name: "PhoneNumberClient", dependencies: [
    "PhoneNumberKit",
    .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
  ]),
  .target(name: "PhotoLibraryClient", dependencies: [
    .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
  ]),
  .target(name: "PhotoLibraryClientLive", dependencies: [
    "PhotoLibraryClient",
  ]),
  .target(name: "UserNotificationClient"),
  .target(name: "UIApplicationClient", dependencies: [
    .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
  ]),
  .target(name: "SnapshotClient", dependencies: [
    "ApolloHelpers",
    "SnapshotModel",
    .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
  ]),
])

// Helpers

package.products.append(contentsOf: [
  .library(name: "SwiftUIHelpers", targets: ["SwiftUIHelpers"]),
  .library(name: "ApolloHelpers", targets: ["ApolloHelpers"]),
])
package.targets.append(contentsOf: [
  .target(name: "SwiftUIHelpers"),
  .target(name: "ColorHex"),
  .testTarget(name: "ColorHexTests", dependencies: [
    "ColorHex",
  ]),
  .target(name: "ApolloHelpers", dependencies: [
    .product(name: "Apollo", package: "apollo-ios"),
    .product(name: "ApolloAPI", package: "apollo-ios"),
  ]),
])

// Widgets

package.products.append(contentsOf: [
  .library(name: "WidgetHelpers", targets: ["WidgetHelpers"]),
  .library(name: "ArtWidgetFeature", targets: ["ArtWidgetFeature"]),
  .library(name: "BalanceWidgetFeature", targets: ["BalanceWidgetFeature"]),
  .library(name: "VotingStatusWidgetFeature", targets: ["VotingStatusWidgetFeature"]),
])
package.targets.append(contentsOf: [
  .target(name: "WidgetHelpers"),
  .target(name: "ArtWidgetFeature", dependencies: [
    "WidgetHelpers",
  ]),
  .target(name: "BalanceWidgetFeature", dependencies: [
    "WidgetHelpers",
  ]),
  .target(name: "VotingStatusWidgetFeature", dependencies: [
    "WidgetHelpers",
    "SnapshotClient",
    "SnapshotModelMock",
  ]),
])
