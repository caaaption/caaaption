import ApolloHelpers
import ComposableArchitecture
import SnapshotModel

public struct ProposalsReducer: ReducerProtocol {
  public init() {}

  public struct State: Equatable {
    public var proposals: IdentifiedArrayOf<WrappedIdentifiable<SnapshotModel.ProposalCardFragment>>

    public init(proposals: IdentifiedArrayOf<WrappedIdentifiable<SnapshotModel.ProposalCardFragment>>) {
      self.proposals = proposals
    }
  }

  public enum Action: Equatable {}

  public var body: some ReducerProtocol<State, Action> {
    Reduce { _, action in
      switch action {}
    }
  }
}
