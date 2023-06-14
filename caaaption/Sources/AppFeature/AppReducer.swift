import ComposableArchitecture
import SwiftUI
import UIApplicationClient
import WidgetSearchFeature

public struct AppReducer: ReducerProtocol {
  public init() {}

  public struct State: Equatable {
    public init() {}

    public var search = WidgetSearchReducer.State()
  }

  public enum Action: Equatable {
    case appDelegate(AppDelegateReducer.Action)
    case sceneDelegate(SceneDelegateReducer.Action)
    case search(WidgetSearchReducer.Action)

    case onOpenURL(URL)
  }

  @Dependency(\.openURL) var openURL

  public var body: some ReducerProtocol<State, Action> {
    Scope(state: \.search, action: /Action.search) {
      WidgetSearchReducer()
    }
    Reduce { _, action in
      switch action {
      case .appDelegate:
        return .none

      case let .sceneDelegate(.shortcutItem(shortcutItem)):
        let urls: [String: URL] = [
          "talk-to-ceo": URL(string: "https://twitter.com/0xsatoya")!,
          "talk-to-lead-dev": URL(string: "https://twitter.com/tomokisun")!,
        ]

        guard let url = urls[shortcutItem.type] else {
          return .none
        }

        return .run { _ in
          await self.openURL(url)
        }

      case .sceneDelegate:
        return .none

      case .search:
        return .none

      case let .onOpenURL(url):
        return .run { _ in
          _ = await self.openURL(url)
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
