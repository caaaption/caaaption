import Apollo
import SnapshotModel

public struct SnapshotClient {
  public var proposal: @Sendable (String) async throws -> AsyncThrowingStream<SnapshotModel.ProposalQuery.Data, Error>
  public var proposals: @Sendable (String) async throws -> AsyncThrowingStream<SnapshotModel.ProposalsQuery.Data, Error>
}
