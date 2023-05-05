import Dependencies
import XCTestDynamicOverlay

public extension DependencyValues {
  var snapshotClient: SnapshotClient {
    get { self[SnapshotClient.self] }
    set { self[SnapshotClient.self] = newValue }
  }
}

extension SnapshotClient: TestDependencyKey {
  public static let previewValue = Self.noop

  public static let testValue = Self(
    proposal: unimplemented("\(Self.self).proposal"),
    proposals: unimplemented("\(Self.self).proposals")
  )
}

public extension SnapshotClient {
  static let noop = Self(
    proposal: { _ in try await Task.never() },
    proposals: { _ in try await Task.never() }
  )
}
