import Apollo
import SnapshotModel

public struct SnapshotClient {
  public var proposal: @Sendable (String) async throws -> SnapshotModel.ProposalQuery.Data
  public var proposals: @Sendable (String) async throws -> SnapshotModel.ProposalsQuery.Data
  public var spaces: @Sendable () async throws -> SnapshotModel.SpacesQuery.Data
}
