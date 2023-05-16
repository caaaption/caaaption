import ComposableArchitecture
import SwiftUI
import WidgetSearchFeature
import UIApplicationClient

public struct AppReducer: ReducerProtocol {
  public init() {}

  public struct State: Equatable {
    public init() {}

    public var search = WidgetSearchReducer.State()
  }

  public enum Action: Equatable {
    case appDelegate(AppDelegateReducer.Action)
    case search(WidgetSearchReducer.Action)
    
    case onOpenURL(URL)
  }
  
  @Dependency(\.applicationClient.open) var openURL

  public var body: some ReducerProtocol<State, Action> {
    Scope(state: \.search, action: /Action.search) {
      WidgetSearchReducer()
    }
    Reduce { _, action in
      switch action {
      case .appDelegate:
        return .none

      case .search:
        return .none

      case let .onOpenURL(url):
        return .run { _ in
          _ = await self.openURL(url, [:])
        }
      }
    }
  }
}

public struct AppView: View {
  let store: StoreOf<AppReducer>

  public init(store: StoreOf<AppReducer>) {
    self.store = store
  }

  public var body: some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
      NavigationStack {
        WidgetSearchView(store: store.scope(state: \.search, action: AppReducer.Action.search))
      }
      .onOpenURL(perform: { viewStore.send(.onOpenURL($0)) })
    }
  }
}
