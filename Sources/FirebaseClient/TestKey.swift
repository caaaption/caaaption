import Foundation
import Dependencies
import XCTestDynamicOverlay

extension DependencyValues {
  public var firebaseClient: FirebaseClient {
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

extension FirebaseClient {
  public static let noop = Self(
    fetchGlobalsConfig: { try await Task.never() }
  )
}
