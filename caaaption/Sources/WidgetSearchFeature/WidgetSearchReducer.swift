import AccountFeature
import ComposableArchitecture

public struct WidgetSearchReducer: ReducerProtocol {
  public init() {}

  public struct State: Equatable {
    public var account = AccountReducer.State()

    @BindingState public var searchable = ""
    @BindingState public var isPresented = false
    public init() {}
  }

  public enum Action: Equatable, BindableAction {
    case account(AccountReducer.Action)

    case task
    case refreshable
    case binding(BindingAction<State>)
  }

  @Dependency(\.mainQueue) var mainQueue
  private enum WidgetRequestID {}

  public var body: some ReducerProtocol<State, Action> {
    BindingReducer()
    Scope(state: \.account, action: /Action.account) {
      AccountReducer()
    }
    Reduce { _, action in
      switch action {
      case .account:
        return EffectTask.none

      case .task:
        return EffectTask.none

      case .refreshable:
        return EffectTask.task {
          try await self.mainQueue.sleep(for: .seconds(2))
          return Action.task
        }
        .animation()
        .cancellable(id: WidgetRequestID.self)

      case .binding:
        return EffectTask.none
      }
    }
  }
}
