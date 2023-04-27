import SnapshotModel
import Apollo

public struct SnapshotClient {
  public var proposal: @Sendable (String) async throws -> GraphQLResult<SnapshotModel.ProposalQuery.Data>
}
