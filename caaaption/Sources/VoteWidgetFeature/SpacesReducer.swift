import ApolloHelpers
import ComposableArchitecture
import Dependencies
import SnapshotClient
import SnapshotModel

public struct SpacesReducer: ReducerProtocol {
  public init() {}

  public struct State: Equatable {
    public var spaces: IdentifiedArrayOf<WrappedIdentifiable<SnapshotModel.SpaceCardFragment>> = []
    @PresentationState var selection: ProposalsReducer.State?
    public init() {}
  }

  public enum Action: Equatable {
    case task
    case responseSpace(TaskResult<SnapshotModel.SpacesQuery.Data>)
    case dismiss
    case tappedSpace(WrappedIdentifiable<SnapshotModel.SpaceCardFragment>)
    case responseProposals(TaskResult<SnapshotModel.ProposalsQuery.Data>)
    case selection(PresentationAction<ProposalsReducer.Action>)
  }

  @Dependency(\.snapshotClient.spaces) var requestSpaces
  @Dependency(\.snapshotClient.proposals) var requestProposals
  @Dependency(\.dismiss) var dismiss

  public var body: some ReducerProtocol<State, Action> {
    Reduce { state, action in
      switch action {
      case .task:
        enum CancelID {}
        return EffectTask.run { send in
          for try await data in self.requestSpaces() {
            await send(.responseSpace(.success(data)), animation: .default)
          }
        } catch: { error, send in
          await send(.responseSpace(.failure(error)), animation: .default)
        }
        .cancellable(id: CancelID.self)

      case let .responseSpace(.success(data)):
        let spaces = data.spaces?.compactMap(\.?.fragments.spaceCardFragment) ?? []
        let sortedSpaces = spaces.sorted(by: { $0.followersCount ?? 0 > $1.followersCount ?? 0 })
        state.spaces.append(contentsOf: sortedSpaces.map(WrappedIdentifiable.init))
        return EffectTask.none

      case let .responseSpace(.failure(error)):
        print(error)
        state.spaces = []
        return EffectTask.none

      case .dismiss:
        return EffectTask.fireAndForget {
          await self.dismiss()
        }
      case let .tappedSpace(space):
        enum CancelID {}
        return EffectTask.run { send in
          for try await data in self.requestProposals(space.value.id) {
            await send(.responseProposals(.success(data)), animation: .default)
          }
        } catch: { error, send in
          await send(.responseProposals(.failure(error)), animation: .default)
        }
        .cancellable(id: CancelID.self)
        
      case let .responseProposals(.success(data)):
        print(data)
        state.selection = .init()
        return EffectTask.none
        
      case let .responseProposals(.failure(error)):
        print(error)
        state.selection = nil
        return EffectTask.none
        
      case .selection:
        return EffectTask.none
      }
    }
    .ifLet(\.$selection, action: /Action.selection) {
      ProposalsReducer()
    }
  }
}
