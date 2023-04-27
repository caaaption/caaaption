public struct SnapshotClient {
  public var proposal: @Sendable (String) async throws -> Void
}
