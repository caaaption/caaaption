import ApolloHelpers
import Foundation
import ComposableArchitecture
import Dependencies
import SnapshotClient
import SnapshotModel

public typealias Space = WrappedIdentifiable<SnapshotModel.SpaceCardFragment>

public struct SpacesReducer: ReducerProtocol {
  public init() {}

  public struct State: Equatable {
    var spaces: IdentifiedArrayOf<Space> = []
    @PresentationState var selection: ProposalsReducer.State?
    public init() {}
  }

  public enum Action: Equatable {
    case task
    case responseSpace(TaskResult<SnapshotModel.SpacesQuery.Data>)
    case dismiss
    case tappedSpace(Space)
    case selection(PresentationAction<ProposalsReducer.Action>)
    case responseProposals(TaskResult<SnapshotModel.ProposalsQuery.Data>)
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
        
      case .selection:
        return EffectTask.none
        
      case let .responseProposals(.success(data)):
        let proposals = data.proposals?.compactMap(\.?.fragments.proposalCardFragment) ?? []
        state.selection = .init(
          proposals: .init(uniqueElements: proposals.map(WrappedIdentifiable.init))
        )
        return EffectTask.none
        
      case let .responseProposals(.failure(error)):
        print(error)
        state.selection = nil
        return EffectTask.none
      }
    }
    .ifLet(\.$selection, action: /Action.selection) {
      ProposalsReducer()
    }
  }
}
