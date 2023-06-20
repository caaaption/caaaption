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
    balance: unimplemented("\(Self.self).balance")
  )
}

public extension QuickNodeClient {
  static let noop = Self(
    balance: { _ in try await Task.never() }
  )
}
