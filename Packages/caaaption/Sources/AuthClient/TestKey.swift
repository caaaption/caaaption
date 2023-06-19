import Dependencies
import XCTestDynamicOverlay

public extension DependencyValues {
  var authClient: AuthClient {
    get { self[AuthClient.self] }
    set { self[AuthClient.self] = newValue }
  }
}

extension AuthClient: TestDependencyKey {
  public static var previewValue = Self.noop

  public static let testValue = Self(
    nonce: unimplemented("\(Self.self).nonce"),
    verify: unimplemented("\(Self.self).verify")
  )
}

public extension AuthClient {
  static let noop = Self(
    nonce: { _ in try await Task.never() },
    verify: { _ in try await Task.never() }
  )
}
