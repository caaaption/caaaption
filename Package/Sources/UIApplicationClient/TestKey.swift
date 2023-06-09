import Dependencies
import XCTestDynamicOverlay

public extension DependencyValues {
  var applicationClient: UIApplicationClient {
    get { self[UIApplicationClient.self] }
    set { self[UIApplicationClient.self] = newValue }
  }
}

extension UIApplicationClient: TestDependencyKey {
  public static let previewValue = Self.noop

  public static let testValue = Self(
    alternateIconName: XCTUnimplemented("\(Self.self).alternateIconName"),
    alternateIconNameAsync: XCTUnimplemented("\(Self.self).alternateIconNameAsync"),
    open: XCTUnimplemented("\(Self.self).open", placeholder: false),
    openSettingsURLString: XCTUnimplemented("\(Self.self).openSettingsURLString"),
    setAlternateIconName: XCTUnimplemented("\(Self.self).setAlternateIconName"),
    setUserInterfaceStyle: XCTUnimplemented("\(Self.self).setUserInterfaceStyle"),
    supportsAlternateIcons: XCTUnimplemented(
      "\(Self.self).supportsAlternateIcons", placeholder: false
    ),
    supportsAlternateIconsAsync: XCTUnimplemented(
      "\(Self.self).setAlternateIconNameAsync", placeholder: false
    )
  )
}

public extension UIApplicationClient {
  static let noop = Self(
    alternateIconName: { nil },
    alternateIconNameAsync: { nil },
    open: { _, _ in false },
    openSettingsURLString: { "settings://caaaption/settings" },
    setAlternateIconName: { _ in },
    setUserInterfaceStyle: { _ in },
    supportsAlternateIcons: { true },
    supportsAlternateIconsAsync: { true }
  )
}
