import ComposableArchitecture
import SnapshotModel

public struct ProposalListReducer: ReducerProtocol {
  public init() {}

  public struct State: Equatable {
    @BindingState public var searchable = ""
    public var proposals: [SnapshotModel.ProposalsQuery.Data.Proposal] = []

    public init(proposals: [SnapshotModel.ProposalsQuery.Data.Proposal] = []) {
      self.proposals = proposals
    }
  }

  public enum Action: Equatable, BindableAction {
    case task
    case refreshable
    case binding(BindingAction<State>)
  }

  public var body: some ReducerProtocol<State, Action> {
    BindingReducer()
    Reduce { _, action in
      switch action {
      case .task:
        return EffectTask.none
        
      case .refreshable:
        return EffectTask.none
        
      case .binding:
        return EffectTask.none
      }
    }
  }
}
