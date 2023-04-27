import ComposableArchitecture
import WidgetSearchFeature
import SwiftUI

public struct AppReducer: ReducerProtocol {
  public init() {}

  public struct State: Equatable {
    public init() {}

    public var search = WidgetSearchReducer.State()
  }

  public enum Action: Equatable {
    case appDelegate(AppDelegateReducer.Action)
    case search(WidgetSearchReducer.Action)
  }

  public var body: some ReducerProtocol<State, Action> {
    Scope(state: \.search, action: /Action.search) {
      WidgetSearchReducer()
    }
  }
}

public struct AppView: View {
  let store: StoreOf<AppReducer>

  public init(store: StoreOf<AppReducer>) {
    self.store = store
  }

  public var body: some View {
    NavigationStack {
      WidgetSearchView(store: store.scope(state: \.search, action: AppReducer.Action.search))
    }
  }
}
