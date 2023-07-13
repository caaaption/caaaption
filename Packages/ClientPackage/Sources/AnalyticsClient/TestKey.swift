import Dependencies
import XCTestDynamicOverlay

public extension DependencyValues {
  var analytics: AnalyticsClient {
    get { self[AnalyticsClient.self] }
    set { self[AnalyticsClient.self] = newValue }
  }
}

extension AnalyticsClient: TestDependencyKey {
  public static let previewValue = Self.noop

  public static let testValue = Self(
    logEvent: unimplemented("\(Self.self).logEvent"),
    setUserId: unimplemented("\(Self.self).setUserId"),
    setUserProperty: unimplemented("\(Self.self).setUserProperty"),
    setAnalyticsCollectionEnabled: unimplemented("\(Self.self).setAnalyticsCollectionEnabled")
  )
}

public extension AnalyticsClient {
  static let noop = Self(
    logEvent: { _, _ in },
    setUserId: { _ in },
    setUserProperty: { _ in },
    setAnalyticsCollectionEnabled: { _ in }
  )
  static let consoleLogger = Self(
    logEvent: { name, parameters in
      print("""
      Analytics: \(name)
      \(parameters ?? [:])
      """)
    },
    setUserId: { print("\(Self.self).setUserId: \($0)") },
    setUserProperty: { print("\(Self.self).setUserProperty: \($0)") },
    setAnalyticsCollectionEnabled: { print("\(Self.self).setAnalyticsCollectionEnabled: \($0)") }
  )
}
