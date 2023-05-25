// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "DependenciesGraph",
  platforms: [.macOS(.v10_13)],
  dependencies: [
    .package(url: "https://github.com/Ryu0118/swift-dependencies-graph", from: "0.0.1"),
  ],
  targets: [.target(name: "DependenciesGraph", path: "")]
)
