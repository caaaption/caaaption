import Dependencies
import XCTestDynamicOverlay

public extension DependencyValues {
  var quickNodeClient: QuickNodeClient {
    get { self[QuickNodeClient.self] }
    set { self[QuickNodeClient.self] = newValue }
  }
}

extension QuickNodeClient: TestDependencyKey {
  public static let testValue = Self(
    getBalance: unimplemented("\(Self.self).getBalance")
  )
}

public extension QuickNodeClient {
  static let noop = Self(
    getBalance: { _ in try await Task.never() }
  )
}
