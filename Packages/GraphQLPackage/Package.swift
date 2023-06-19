// swift-tools-version: 5.7
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
    .package(url: "https://github.com/apollographql/apollo-ios", from: "1.2.2"),
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
