import ComposableArchitecture
import UIKit

public struct SceneDelegateReducer: ReducerProtocol {
  public struct State: Equatable {}
  public enum Action: Equatable {
    case shortcutItem(UIApplicationShortcutItem)
  }
  
  @Dependency(\.openURL) var openURL
  
  public func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
    switch action {
    case let .shortcutItem(shortcutItem):
      let urls: [String: URL] = [
        "talk-to-ceo": URL(string: "https://twitter.com/0xsatoya")!,
        "talk-to-lead-dev": URL(string: "https://twitter.com/tomokisun")!
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
