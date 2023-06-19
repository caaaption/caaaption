import Apollo
import SnapshotModel

public struct SnapshotClient {
  public var proposal: @Sendable (String) async throws -> GraphQLResult<SnapshotModel.ProposalQuery.Data>
  public var proposals: @Sendable (String) -> AsyncThrowingStream<SnapshotModel.ProposalsQuery.Data, Error>
  public var spaces: @Sendable () -> AsyncThrowingStream<SnapshotModel.SpacesQuery.Data, Error>
}
