// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "XCTemplateInstallerTool",
  platforms: [.macOS(.v10_13)],
  dependencies: [
    .package(url: "https://github.com/noppefoxwolf/XCTemplateInstaller", from: "1.0.5"),
  ],
  targets: [.target(name: "XCTemplateInstallerTool", path: "")]
)
