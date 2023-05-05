import AccountFeature
import BalanceWidgetFeature
import ComposableArchitecture
import VoteWidgetFeature

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
      case vote
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

      case let .tapped(distination):
        switch distination {
        case .account:
          state.destination = .account(
            AccountReducer.State()
          )
        case .balance:
          state.destination = .balance(
            BalanceSettingReducer.State()
          )
        case .vote:
          state.destination = .vote(
            SpacesReducer.State()
          )
        }
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
      case vote(SpacesReducer.State)
    }

    public enum Action: Equatable {
      case account(AccountReducer.Action)
      case balance(BalanceSettingReducer.Action)
      case vote(SpacesReducer.Action)
    }

    public var body: some ReducerProtocol<State, Action> {
      Scope(state: /State.account, action: /Action.account) {
        AccountReducer()
      }
      Scope(state: /State.balance, action: /Action.balance) {
        BalanceSettingReducer()
      }
      Scope(state: /State.vote, action: /Action.vote) {
        SpacesReducer()
      }
    }
  }
}
