import SnapshotGraphQLModel
import Apollo

public struct SnapshotClient {
  public var proposal: @Sendable (String) async throws -> GraphQLResult<SnapshotGraphQLModel.ProposalQuery.Data>
}
