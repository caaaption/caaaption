import ApolloHelpers
import ComposableArchitecture
import Dependencies
import Foundation
import SnapshotClient
import SnapshotModel
import SwiftUI

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
        return EffectTask.run { _ in
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

public struct SpacesView: View {
  let store: StoreOf<SpacesReducer>

  public init(store: StoreOf<SpacesReducer>) {
    self.store = store
  }

  public var body: some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
      List {
        ForEach(viewStore.spaces, id: \.id) { space in
          Button {
            viewStore.send(.tappedSpace(space))
          } label: {
            HStack {
              Text(space.value.name ?? space.value.id)
                .foregroundColor(.primary)
              Spacer()
              Image(systemName: "chevron.right")
                .foregroundColor(.gray)
            }
          }
        }
        .navigationDestination(
          store: store.scope(
            state: \.$selection,
            action: SpacesReducer.Action.selection
          ),
          destination: ProposalsView.init(store:)
        )
      }
      .navigationTitle("Spaces")
      .navigationBarTitleDisplayMode(.inline)
      .task { await viewStore.send(.task).finish() }
      .toolbar {
        ToolbarItem(placement: .navigationBarTrailing) {
          Button {
            viewStore.send(.dismiss)
          } label: {
            Image(systemName: "xmark.circle.fill")
              .symbolRenderingMode(.palette)
              .foregroundStyle(.gray, .bar)
              .font(.system(size: 30))
          }
        }
      }
    }
  }
}
