// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "GraphQLPackage",
  platforms: [
    .iOS(.v16)
  ],
  products: [
    .library(name: "SnapshotModel", targets: ["SnapshotModel"]),
  ],
  dependencies: [
    .package(url: "https://github.com/apollographql/apollo-ios.git", from: "1.0.0"),
  ],
  targets: [
    .target(
      name: "SnapshotModel",
      dependencies: [
        .product(name: "ApolloAPI", package: "apollo-ios"),
      ]
    ),
  ]
)
