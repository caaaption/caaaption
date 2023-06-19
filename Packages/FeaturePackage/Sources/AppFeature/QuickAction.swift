import ComposableArchitecture
import UIKit

public struct QuickActionReducer: ReducerProtocol {
  public struct State: Equatable {}
  public enum Action: Equatable {
    case quickAction(UIApplicationShortcutItem)
  }
  
  @Dependency(\.openURL) var openURL

  public var body: some ReducerProtocol<State, Action> {
    Reduce { _, action in
      switch action {
      case let .quickAction(shortcutItem):
        let urls: [String: URL] = [
          "talk-to-founder": URL(string: "https://twitter.com/0xsatoya")!,
          "talk-to-lead-dev": URL(string: "https://twitter.com/tomokisun")!,
        ]

        guard let url = urls[shortcutItem.type] else {
          return .none
        }

        return .run { _ in
          await self.openURL(url)
        }
      }
    }
  }
}
