import AccountFeature
import BalanceWidgetFeature
import ComposableArchitecture

public struct WidgetSearchReducer: ReducerProtocol {
  public init() {}

  public struct State: Equatable {
    @PresentationState public var destination: Destination.State?
    @BindingState public var searchable = ""
    public init() {}
  }

  public enum Action: Equatable, BindableAction {
    case destination(PresentationAction<Destination.Action>)
    case tapped(Tapped)

    case task
    case refreshable
    case binding(BindingAction<State>)
    case dismiss

    public enum Tapped: Equatable {
      case account
      case balance
    }
  }

  @Dependency(\.mainQueue) var mainQueue
  private enum WidgetRequestID {}

  public var body: some ReducerProtocol<State, Action> {
    BindingReducer()
    Reduce { state, action in
      switch action {
      case .destination:
        return EffectTask.none

      case .tapped(.account):
        state.destination = .account(
          AccountReducer.State()
        )
        return EffectTask.none

      case .tapped(.balance):
        state.destination = .balance(
          BalanceSettingReducer.State()
        )
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

      case .dismiss:
        return EffectTask.none
      }
    }
    .ifLet(\.$destination, action: /Action.destination) {
      Destination()
    }
  }
}

public extension WidgetSearchReducer {
  struct Destination: ReducerProtocol {
    public enum State: Equatable {
      case account(AccountReducer.State)
      case balance(BalanceSettingReducer.State)
    }

    public enum Action: Equatable {
      case account(AccountReducer.Action)
      case balance(BalanceSettingReducer.Action)
    }

    public var body: some ReducerProtocol<State, Action> {
      Scope(state: /State.account, action: /Action.account) {
        AccountReducer()
      }
      Scope(state: /State.balance, action: /Action.balance) {
        BalanceSettingReducer()
      }
    }
  }
}
