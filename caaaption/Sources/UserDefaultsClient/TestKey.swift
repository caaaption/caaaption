import Dependencies
import Foundation
import XCTestDynamicOverlay

public extension DependencyValues {
  var userDefaults: UserDefaultsClient {
    get { self[UserDefaultsClient.self] }
    set { self[UserDefaultsClient.self] = newValue }
  }
}

extension UserDefaultsClient: TestDependencyKey {
  public static let previewValue = Self.noop

  public static let testValue = Self(
    boolForKey: unimplemented("\(Self.self).boolForKey", placeholder: false),
    dataForKey: unimplemented("\(Self.self).dataForKey", placeholder: nil),
    doubleForKey: unimplemented("\(Self.self).doubleForKey", placeholder: 0),
    integerForKey: unimplemented("\(Self.self).integerForKey", placeholder: 0),
    remove: unimplemented("\(Self.self).remove"),
    setBool: unimplemented("\(Self.self).setBool"),
    setData: unimplemented("\(Self.self).setData"),
    setDouble: unimplemented("\(Self.self).setDouble"),
    setInteger: unimplemented("\(Self.self).setInteger")
  )
}

public extension UserDefaultsClient {
  static let noop = Self(
    boolForKey: { _ in false },
    dataForKey: { _ in nil },
    doubleForKey: { _ in 0 },
    integerForKey: { _ in 0 },
    remove: { _ in },
    setBool: { _, _ in },
    setData: { _, _ in },
    setDouble: { _, _ in },
    setInteger: { _, _ in }
  )
}
