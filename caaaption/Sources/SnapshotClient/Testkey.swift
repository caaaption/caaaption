import Dependencies
import XCTestDynamicOverlay

public extension DependencyValues {
  var snapshotClient: SnapshotClient {
    get { self[SnapshotClient.self] }
    set { self[SnapshotClient.self] = newValue }
  }
}

extension SnapshotClient: TestDependencyKey {
  public static let testValue = Self(
    proposal: unimplemented("\(Self.self).proposal"),
    proposals: unimplemented("\(Self.self).proposals"),
    spaces: unimplemented("\(Self.self).spaces")
  )
}
