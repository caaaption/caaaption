import AccountFeature
import BalanceWidget
import BalanceWidgetFeature
import ComposableArchitecture
import SwiftUI
import VoteWidget
import VoteWidgetFeature

public struct WidgetSearchReducer: ReducerProtocol {
  public init() {}

  public struct State: Equatable {
    @PresentationState public var destination: Destination.State?
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

public struct WidgetSearchView: View {
  let store: StoreOf<WidgetSearchReducer>

  public init(store: StoreOf<WidgetSearchReducer>) {
    self.store = store
  }

  public var body: some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
      List {
        Button {
          viewStore.send(.tapped(.balance))
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
          viewStore.send(.tapped(.vote))
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
      }
      .listStyle(.plain)
      .navigationTitle("Widget Search")
      .task { await viewStore.send(.task).finish() }
      .refreshable { await viewStore.send(.refreshable).finish() }
      .toolbar {
        ToolbarItem(placement: .navigationBarTrailing) {
          Button {
            viewStore.send(.tapped(.account))
          } label: {
            Color.red
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
