import ComposableArchitecture
import SwiftUI
import WidgetTabFeature

public struct AppReducer: ReducerProtocol {
  public init() {}

  public struct State: Equatable {
    public init() {}

    public var widget = WidgetTabReducer.State()
  }

  public enum Action: Equatable {
    case appDelegate(AppDelegateReducer.Action)
    case sceneDelegate(SceneDelegateReducer.Action)
    case widget(WidgetTabReducer.Action)

    case onOpenURL(URL)
  }

  @Dependency(\.openURL) var openURL

  public var body: some ReducerProtocol<State, Action> {
    Scope(state: \.widget, action: /Action.widget) {
      WidgetTabReducer()
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
