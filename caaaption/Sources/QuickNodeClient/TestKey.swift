import Dependencies
import XCTestDynamicOverlay

extension DependencyValues {
  public var quickNodeClient: QuickNodeClient {
    get { self[QuickNodeClient.self] }
    set { self[QuickNodeClient.self] = newValue }
  }
}

extension QuickNodeClient: TestDependencyKey {
  public static let testValue = Self(
    getBalance: unimplemented("\(Self.self).getBalance")
  )
}

extension QuickNodeClient {
  public static let noop = Self(
    getBalance: { _ in try await Task.never() }
  )
}
