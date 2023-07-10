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
    send: unimplemented("\(Self.self).send"),
    setAnalyticsCollectionEnabled: unimplemented("\(Self.self).setAnalyticsCollectionEnabled")
  )
}

public extension AnalyticsClient {
  static let noop = Self(
    send: { _ in },
    setAnalyticsCollectionEnabled: { _ in }
  )
  static let consoleLogger = Self(
    send: { analytics in
      print("[Analytics] ✅ \(analytics)")
    },
    setAnalyticsCollectionEnabled: { value in
      print("setAnalyticsCollectionEnabled: \(value)")
    }
  )
}
