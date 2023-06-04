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
    listen: unimplemented("\(Self.self).listen")
  )
}

public extension FirestoreClient {
  static let noop = Self(
    listen: { .never }
  )
}
