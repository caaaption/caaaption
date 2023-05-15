# caaaption

<img src='./App/WidgetApp/Assets.xcassets/AppIcon.appiconset/icon_pink4-1024.png' width='300'>

<div align='left'>
    <img src='https://github.com/caaaption/caaaption/actions/workflows/ci.yml/badge.svg'>
    <img src='https://github.com/tomokisun/caaaption/actions/workflows/format.yml/badge.svg'>
    <a href="https://twitter.com/caaaption">
      <img src="https://img.shields.io/twitter/follow/caaaption?label=caaaption&style=flat&logo=twitter&color=1DA1F2" alt="caaaption twitter">
    </a>
    <img src='https://img.shields.io/badge/language-Swift-orange.svg'>
    <img src='https://img.shields.io/badge/platform-iOS%20-green.svg'>
</div>

This repo contains the full source code for [caaaption](https://caaaption.com), Get real-time dApps information on iPhone widgets. 

---

- [About](#about)
- [TestFlight](#testflight)
- [Getting Started](#getting-started)
- [Related Projects](#related-projects)
- [License](#license)

# About

[caaaption](https://caaaption.com) is an application built entirely in Swift. The logic is built with [Composable Architecture](https://github.com/pointfreeco/swift-composable-architecture) and the UI is  built mostly in SwiftUI.

# TestFlight

You can install TestFlight by minting an Early Access Pass with Zora.

http://mint.caaaption.com

# Getting Started

This repo contains both the client code for running the entire [caaaption](https://caaaption.com) application, as well as a test case. To get things running:

1. Grab the code:
    ```sh
    git clone https://github.com/caaaption/caaaption
    cd caaaption
    ```
2. `make open` or Open the Xcode workspace `caaaption.xcworkspace`
3. To run the client locally. select the `App (Widget Staging project)` target in Xcode and run (`⌘R`).

# Related Projects

[caaaption](https://caaaption.com) uses many open source projects, including

- [Composable Architecture](https://github.com/pointfreeco/swift-composable-architecture)
- [SwiftFormat](https://github.com/nicklockwood/SwiftFormat)
- [XCTemplateInstaller](https://github.com/noppefoxwolf/XCTemplateInstaller)
- [apollo-ios](https://github.com/apollographql/apollo-ios)

# License

For more information see our full [license](./LICENSE).

