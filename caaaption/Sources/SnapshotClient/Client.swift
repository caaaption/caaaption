import Apollo
import SnapshotModel

public struct SnapshotClient {
  public var proposal: @Sendable (String) -> AsyncThrowingStream<SnapshotModel.ProposalQuery.Data, Error>
  public var proposals: @Sendable (String) -> AsyncThrowingStream<SnapshotModel.ProposalsQuery.Data, Error>
}
