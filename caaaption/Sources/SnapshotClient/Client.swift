import Apollo
import SnapshotModel

public struct SnapshotClient {
  public var proposal: @Sendable (String) async throws -> GraphQLResult<SnapshotModel.ProposalQuery.Data>
}
