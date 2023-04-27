import SnapshotGraphQLModel

public struct SnapshotClient {
  public var proposal: @Sendable (String) async throws -> SnapshotGraphQLModel.ProposalQuery.Data.Proposal
}
