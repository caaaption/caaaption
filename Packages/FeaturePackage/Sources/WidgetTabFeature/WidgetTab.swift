import AccountFeature
import ComposableArchitecture
import SwiftUI
import WidgetSearchFeature

public struct WidgetTabReducer: ReducerProtocol {
  public init() {}

  public struct State: Equatable {
    var widgetSearch = WidgetSearchReducer.State()

    @PresentationState var destination: Destination.State?
    public init() {}
  }

  public enum Action: Equatable {
    case widgetSearch(WidgetSearchReducer.Action)
    case destination(PresentationAction<Destination.Action>)
    case accountButtonTapped
  }

  public var body: some ReducerProtocol<State, Action> {
    Scope(state: \.widgetSearch, action: /Action.widgetSearch) {
      WidgetSearchReducer()
    }
    Reduce { state, action in
      switch action {
      case .widgetSearch:
        return .none

      case .destination:
        return .none

      case .accountButtonTapped:
        state.destination = .account()
        return .none
      }
    }
    .ifLet(\.$destination, action: /Action.destination) {
      Destination()
    }
  }

  public struct Destination: ReducerProtocol {
    public enum State: Equatable {
      case account(AccountReducer.State = .init())
    }

    public enum Action: Equatable {
      case account(AccountReducer.Action)
    }

    public var body: some ReducerProtocol<State, Action> {
      Scope(state: /State.account, action: /Action.account) {
        AccountReducer()
      }
    }
  }
}

public struct WidgetTabView: View {
  let store: StoreOf<WidgetTabReducer>

  public init(store: StoreOf<WidgetTabReducer>) {
    self.store = store
  }

  public var body: some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
      NavigationStack {
        WidgetSearchView(
          store: store.scope(
            state: \.widgetSearch,
            action: WidgetTabReducer.Action.widgetSearch
          )
        )
        .toolbar {
          ToolbarItem(placement: .navigationBarTrailing) {
            Button {
              viewStore.send(.accountButtonTapped)
            } label: {
              Image(systemName: "gearshape.fill")
            }
          }
        }
        .sheet(
          store: store.scope(
            state: \.$destination,
            action: WidgetTabReducer.Action.destination
          ),
          state: /WidgetTabReducer.Destination.State.account,
          action: WidgetTabReducer.Destination.Action.account
        ) { store in
          NavigationStack {
            AccountView(store: store)
          }
        }
      }
    }
  }
}

#if DEBUG
  import SwiftUIHelpers

  struct WidgetTabViewPreviews: PreviewProvider {
    static var previews: some View {
      Preview {
        WidgetTabView(
          store: .init(
            initialState: WidgetTabReducer.State(),
            reducer: WidgetTabReducer()
          )
        )
      }
    }
  }
#endif
