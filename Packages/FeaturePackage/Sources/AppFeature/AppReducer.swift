import ComposableArchitecture
import SwiftUI
import WidgetTabFeature
import ServerConfigClient

public struct AppReducer: ReducerProtocol {
  public init() {}

  public struct State: Equatable {
    public init() {}

    var appDelegate = AppDelegateReducer.State()
    var sceneDelegate = SceneDelegateReducer.State()
    var widget = WidgetTabReducer.State()
  }

  public enum Action: Equatable {
    case appDelegate(AppDelegateReducer.Action)
    case sceneDelegate(SceneDelegateReducer.Action)
    case widget(WidgetTabReducer.Action)

    case quickAction(UIApplicationShortcutItem)
    case onOpenURL(URL)
  }

  @Dependency(\.openURL) var openURL
  @Dependency(\.serverConfig.config) var serverConfig

  public var body: some ReducerProtocol<State, Action> {
    Scope(state: \.appDelegate, action: /Action.appDelegate) {
      AppDelegateReducer()
    }
    Scope(state: \.sceneDelegate, action: /Action.sceneDelegate) {
      SceneDelegateReducer()
    }
    Scope(state: \.widget, action: /Action.widget) {
      WidgetTabReducer()
    }
    Reduce { _, action in
      switch action {
      case let .appDelegate(.configurationForConnecting(.some(shortcutItem))):
        return .run { send in
          await send(.quickAction(shortcutItem))
        }

      case .appDelegate:
        return .none

      case let .sceneDelegate(.shortcutItem(shortcutItem)):
        return .run { send in
          await send(.quickAction(shortcutItem))
        }

      case .sceneDelegate:
        return .none
        
      case let .quickAction(shortcutItem):
        let urls: [String: URL] = [
          "talk-to-founder": serverConfig().founderURL,
          "talk-to-lead-dev": serverConfig().leadDevURL
        ]

        guard let url = urls[shortcutItem.type] else {
          return .none
        }

        return .run { _ in
          await self.openURL(url)
        }

      case .widget:
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
    NavigationStack {
      WidgetTabView(store: store.scope(state: \.widget, action: AppReducer.Action.widget))
    }
    .onOpenURL(perform: { ViewStore(store).send(.onOpenURL($0)) })
  }
}
