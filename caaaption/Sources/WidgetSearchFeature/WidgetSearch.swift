import AccountFeature
import BalanceWidget
import BalanceWidgetFeature
import ComposableArchitecture
import PlaceholderAsyncImage
import SwiftUI
import VoteWidget
import VoteWidgetFeature
import POAPWidgetFeature
import POAPWidget

public struct WidgetSearchReducer: ReducerProtocol {
  public init() {}

  public struct State: Equatable {
    @PresentationState public var destination: Destination.State?
    public init() {}
  }

  public enum Action: Equatable {
    case destination(PresentationAction<Destination.Action>)
    case accountButtonTapped
    case balanceButtonTapped
    case voteButtonTapped
    case poapButtonTapped
  }

  @Dependency(\.mainQueue) var mainQueue

  public var body: some ReducerProtocol<State, Action> {
    Reduce { state, action in
      switch action {
      case .destination:
        return EffectTask.none

      case .accountButtonTapped:
        state.destination = .account()
        return .none

      case .balanceButtonTapped:
        state.destination = .balance()
        return .none

      case .voteButtonTapped:
        state.destination = .vote()
        return .none
        
      case .poapButtonTapped:
        state.destination = .poap()
        return .none
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
      case account(AccountReducer.State = .init())
      case balance(BalanceSettingReducer.State = .init())
      case vote(SpacesReducer.State = .init())
      case poap(MyPOAPReducer.State = .init())
    }

    public enum Action: Equatable {
      case account(AccountReducer.Action)
      case balance(BalanceSettingReducer.Action)
      case vote(SpacesReducer.Action)
      case poap(MyPOAPReducer.Action)
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
      Scope(state: /State.poap, action: /Action.poap) {
        MyPOAPReducer()
      }
    }
  }
}

public struct WidgetSearchView: View {
  let store: StoreOf<WidgetSearchReducer>

  public init(store: StoreOf<WidgetSearchReducer>) {
    self.store = store
  }

  public var body: some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
      List {
        Button {
          viewStore.send(.balanceButtonTapped)
        } label: {
          ListCard(BalanceWidget.self)
        }
        .sheet(
          store: store.scope(
            state: \.$destination,
            action: WidgetSearchReducer.Action.destination
          ),
          state: /WidgetSearchReducer.Destination.State.balance,
          action: WidgetSearchReducer.Destination.Action.balance
        ) { store in
          NavigationStack {
            BalanceSettingView(store: store)
          }
        }

        Button {
          viewStore.send(.voteButtonTapped)
        } label: {
          ListCard(VoteWidget.self)
        }
        .sheet(
          store: store.scope(
            state: \.$destination,
            action: WidgetSearchReducer.Action.destination
          ),
          state: /WidgetSearchReducer.Destination.State.vote,
          action: WidgetSearchReducer.Destination.Action.vote
        ) { store in
          NavigationStack {
            SpacesView(store: store)
          }
        }
        
        Button {
          viewStore.send(.poapButtonTapped)
        } label: {
          ListCard(POAPWidget.self)
        }
        .sheet(
          store: store.scope(
            state: \.$destination,
            action: WidgetSearchReducer.Action.destination
          ),
          state: /WidgetSearchReducer.Destination.State.poap,
          action: WidgetSearchReducer.Destination.Action.poap
        ) { store in
          NavigationStack {
            MyPOAPView(store: store)
          }
        }
      }
      .listStyle(.plain)
      .navigationTitle("Widget")
      .toolbar {
        ToolbarItem(placement: .navigationBarTrailing) {
          Button {
            viewStore.send(.accountButtonTapped)
          } label: {
            PlaceholderAsyncImage(
              url: URL(
                string: "https://i.seadn.io/gae/c_u0e9m4wH4zgsJowfOOHd-EkQEzuxiEUZTsUsEbcc-sSJgmGX6uHMRX8pMgC6OQbfJ987nrF0-CSwGaBDQuS1tAe2w7B0eaAEj_?w=500&auto=format"
              )
            )
            .frame(width: 36, height: 36)
            .clipShape(Circle())
          }
        }
      }
      .sheet(
        store: store.scope(
          state: \.$destination,
          action: WidgetSearchReducer.Action.destination
        ),
        state: /WidgetSearchReducer.Destination.State.account,
        action: WidgetSearchReducer.Destination.Action.account
      ) { store in
        NavigationStack {
          AccountView(store: store)
        }
      }
    }
  }
}

#if DEBUG
  import SwiftUIHelpers

  struct WidgetSearchViewPreviews: PreviewProvider {
    static var previews: some View {
      Preview {
        NavigationStack {
          WidgetSearchView(
            store: .init(
              initialState: WidgetSearchReducer.State(),
              reducer: WidgetSearchReducer()
            )
          )
        }
      }
    }
  }
#endif
