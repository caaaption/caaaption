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
  )
}

public extension AnalyticsClient {
  static let noop = Self(
  )
}
