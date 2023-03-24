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
  ]
)

/// Features
package.products.append(contentsOf: [
  .library(name: "AppFeature", targets: ["AppFeature"]),
  .library(name: "OnboardFeature", targets: ["OnboardFeature"]),
  .library(name: "FeedFeature", targets: ["FeedFeature"]),
  .library(name: "UploadFeature", targets: ["UploadFeature"])
])
package.targets.append(contentsOf: [
  .target(name: "AppFeature", dependencies: [
    .product(name: "ComposableArchitecture", package: "swift-composable-architecture")
  ]),
  .target(name: "OnboardFeature", dependencies: [
    "DesignSystem",
    "SwiftUIHelpers",
    "PhoneNumberClient",
    .product(name: "ComposableArchitecture", package: "swift-composable-architecture")
  ]),
  .target(name: "FeedFeature", dependencies: [
    "DesignSystem",
    .product(name: "ComposableArchitecture", package: "swift-composable-architecture")
  ]),
  .target(name: "UploadFeature", dependencies: [
    "ColorHex",
    "SwiftUIHelpers",
    "PhotoLibraryClient",
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
  .library(name: "FirebaseClientLive", targets: ["FirebaseClientLive"]),
  .library(name: "PhoneNumberClient", targets: ["PhoneNumberClient"]),
  .library(name: "PhotoLibraryClientLive", targets: ["PhotoLibraryClientLive"])
])
package.targets.append(contentsOf: [
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
  .target(name: "ColorHex")
])
