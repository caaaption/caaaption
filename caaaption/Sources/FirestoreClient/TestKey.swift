import Dependencies
import XCTestDynamicOverlay

public extension DependencyValues {
  var firestoreClient: FirestoreClient {
    get { self[FirestoreClient.self] }
    set { self[FirestoreClient.self] = newValue }
  }
}

extension FirestoreClient: TestDependencyKey {
  public static let previewValue = Self.noop
  
  public static let testValue = Self(
  )
}

public extension FirestoreClient {
  static let noop = Self(
  )
}
