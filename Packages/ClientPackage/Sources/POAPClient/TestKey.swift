import Dependencies
import XCTestDynamicOverlay

public extension DependencyValues {
  var poapClient: POAPClient {
    get { self[POAPClient.self] }
    set { self[POAPClient.self] = newValue }
  }
}

extension POAPClient: TestDependencyKey {
  public static let testValue = Self(
    scan: unimplemented("\(Self.self).scan")
  )
}

public extension POAPClient {
  static let noop = Self(
    scan: { _ in try await Task.never() }
  )
}
