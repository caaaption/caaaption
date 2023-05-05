import ComposableArchitecture
import Dependencies
import SnapshotClient
import SnapshotModel

public struct SpacesReducer: ReducerProtocol {
  public init() {}

  public struct State: Equatable {
    public var spaces: [SnapshotModel.SpaceCardFragment] = []
    public init() {}
  }

  public enum Action: Equatable {
    case task
    case responseSpace(TaskResult<SnapshotModel.SpacesQuery.Data>)
    case dismiss
  }

  @Dependency(\.snapshotClient.spaces) var spaces
  @Dependency(\.dismiss) var dismiss

  public var body: some ReducerProtocol<State, Action> {
    Reduce { state, action in
      switch action {
      case .task:
        enum CancelID {}
        return EffectTask.run { send in
          for try await data in self.spaces() {
            await send(.responseSpace(.success(data)), animation: .default)
          }
        } catch: { error, send in
          await send(.responseSpace(.failure(error)), animation: .default)
        }
        .cancellable(id: CancelID.self)

      case let .responseSpace(.success(data)):
        state.spaces = data.spaces?.compactMap(\.?.fragments.spaceCardFragment) ?? []
        return EffectTask.none

      case let .responseSpace(.failure(error)):
        print(error)
        state.spaces = []
        return EffectTask.none

      case .dismiss:
        return EffectTask.fireAndForget {
          await self.dismiss()
        }
      }
    }
  }
}
