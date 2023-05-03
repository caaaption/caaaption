import ComposableArchitecture
import SnapshotClient
import SnapshotModel

public struct SpaceListReducer: ReducerProtocol {
  public init() {}

  public struct State: Equatable {
    @BindingState public var searchable = ""
    public var spaces: [SnapshotModel.SpacesQuery.Data.Space] = []
    var selection: Identified<String, ProposalListReducer.State?>?

    public init() {}
  }

  public enum Action: Equatable, BindableAction {
    case proposals(ProposalListReducer.Action)
    case task
    case refreshable
    case binding(BindingAction<State>)
    case responseSpaces(TaskResult<SnapshotModel.SpacesQuery.Data>)
    case setNavigation(id: String)
    case responseProposals(TaskResult<SnapshotModel.ProposalsQuery.Data>)
  }
  
  @Dependency(\.snapshotClient.spaces) var spaces
  @Dependency(\.snapshotClient.proposals) var proposals

  public var body: some ReducerProtocol<State, Action> {
    BindingReducer()
    Reduce { state, action in
      switch action {
      case .proposals:
        return EffectTask.none
        
      case .task:
        return EffectTask.task {
          await .responseSpaces(
            TaskResult {
              try await spaces()
            }
          )
        }
        
      case .refreshable:
        return EffectTask.none
        
      case .binding:
        return EffectTask.none
        
      case let .responseSpaces(.success(data)):
        let spaces = data.spaces ?? []
        state.spaces = spaces
          .compactMap { $0 }
        return EffectTask.none

      case .responseSpaces(.failure):
        return EffectTask.none
        
      case let .setNavigation(id):
        guard let spaceName = state.spaces.first(where: { $0.id == id })?.name else {
          return EffectTask.none
        }
        return EffectTask.task {
          await .responseProposals(
            TaskResult {
              try await proposals(spaceName)
            }
          )
        }
        
      case let .responseProposals(.success(data)):
        let proposals = data.proposals ?? []
        state.selection?.value = ProposalListReducer.State(
          proposals: proposals.compactMap { $0 }
        )
        return EffectTask.none

      case .responseProposals(.failure):
        return EffectTask.none
      }
    }
    .ifLet(\.selection, action: /Action.proposals) {
      EmptyReducer()
        .ifLet(\Identified<String, ProposalListReducer.State?>.value, action: .self) {
          ProposalListReducer()
        }
    }
  }
}
