import Dependencies
import Foundation
import XCTestDynamicOverlay

public extension DependencyValues {
  var firebaseClient: FirebaseClient {
    get { self[FirebaseClient.self] }
    set { self[FirebaseClient.self] = newValue }
  }
}

extension FirebaseClient: TestDependencyKey {
  public static let previewValue = Self.noop

  public static let testValue = Self(
    fetchGlobalsConfig: XCTUnimplemented("\(Self.self).fetchGlobasConfig")
  )
}

public extension FirebaseClient {
  static let noop = Self(
    fetchGlobalsConfig: { try await Task.never() }
  )
}
