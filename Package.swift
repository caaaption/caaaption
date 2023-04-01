// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

var package = Package(
  name: "Caption",
  defaultLocalization: "en",
  platforms: [
    .iOS(.v16),
  ],
  dependencies: [
    .package(url: "https://github.com/pointfreeco/swift-composable-architecture", from: "0.51.0"),
    .package(url: "https://github.com/marmelroy/PhoneNumberKit", from: "3.4.0"),
    .package(url: "https://github.com/JWAutumn/ACarousel", from: "0.2.0"),
  ]
)

/// Features
package.products.append(contentsOf: [
  .library(name: "AppFeature", targets: ["AppFeature"]),
  .library(name: "MainTabFeature", targets: ["MainTabFeature"]),
  .library(name: "ContentFeature", targets: ["ContentFeature"]),
  .library(name: "OnboardFeature", targets: ["OnboardFeature"]),
  .library(name: "FeedFeature", targets: ["FeedFeature"]),
  .library(name: "UploadFeature", targets: ["UploadFeature"]),
  .library(name: "ProfileFeature", targets: ["ProfileFeature"])
])
package.targets.append(contentsOf: [
  .target(name: "AppFeature", dependencies: [
    "MainTabFeature"
  ]),
  .target(name: "MainTabFeature", dependencies: [
    "FeedFeature",
    "UploadFeature",
    "ProfileFeature"
  ]),
  .target(name: "ContentFeature", dependencies: [
    "SwiftUIHelpers",
    .product(name: "ComposableArchitecture", package: "swift-composable-architecture")
  ]),
  .target(name: "OnboardFeature", dependencies: [
    "DesignSystem",
    "SwiftUIHelpers",
    "PhoneNumberClient",
    .product(name: "ComposableArchitecture", package: "swift-composable-architecture")
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
    .product(name: "ComposableArchitecture", package: "swift-composable-architecture")
  ]),
  .target(name: "ProfileFeature", dependencies: [
    "SwiftUIHelpers",
    .product(name: "ComposableArchitecture", package: "swift-composable-architecture")
  ])
])

// UI

package.products.append(contentsOf: [
  .library(name: "DesignSystem", targets: ["DesignSystem"]),
  .library(name: "Styleguide", targets: ["Styleguide"])
])
package.targets.append(contentsOf: [
  .target(name: "DesignSystem"),
  .target(name: "Styleguide"),
])

// Client

package.products.append(contentsOf: [
  .library(name: "AVFoundationClient", targets: ["AVFoundationClient"]),
  .library(name: "FirebaseClientLive", targets: ["FirebaseClientLive"]),
  .library(name: "PhoneNumberClient", targets: ["PhoneNumberClient"]),
  .library(name: "PhotoLibraryClientLive", targets: ["PhotoLibraryClientLive"])
])
package.targets.append(contentsOf: [
  .target(name: "AVFoundationClient", dependencies: [
    .product(name: "ComposableArchitecture", package: "swift-composable-architecture")
  ]),
  .target(name: "FirebaseClient", dependencies: [
    .product(name: "ComposableArchitecture", package: "swift-composable-architecture")
  ]),
  .target(name: "FirebaseClientLive", dependencies: [
    "FirebaseClient",
  ]),
  .target(name: "PhoneNumberClient", dependencies: [
    "PhoneNumberKit",
    .product(name: "ComposableArchitecture", package: "swift-composable-architecture")
  ]),
  .target(name: "PhotoLibraryClient", dependencies: [
    .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
  ]),
  .target(name: "PhotoLibraryClientLive", dependencies: [
    "PhotoLibraryClient"
  ]),
])

// Helpers

package.products.append(contentsOf: [
  .library(name: "SwiftUIHelpers", targets: ["SwiftUIHelpers"]),
])
package.targets.append(contentsOf: [
  .target(name: "SwiftUIHelpers"),
  .target(name: "ColorHex"),
  .testTarget(name: "ColorHexTests", dependencies: [
    "ColorHex"
  ])
])
