import ComposableArchitecture
import UIKit

public struct SceneDelegateReducer: ReducerProtocol {
  public struct State: Equatable {}
  public enum Action: Equatable {
    case shortcutItem(UIApplicationShortcutItem)
    case quickAction(QuickActionReducer.Action)
  }

  @Dependency(\.openURL) var openURL

  public func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
    switch action {
    case let .shortcutItem(shortcutItem):
      return .run { @Sendable send in
        await send(.quickAction(.quickAction(shortcutItem)))
      }
    case .quickAction:
      return .none
    }
  }
}
