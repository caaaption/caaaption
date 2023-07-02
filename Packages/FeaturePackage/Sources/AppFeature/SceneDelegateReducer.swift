import ComposableArchitecture
import UIKit

public struct SceneDelegateReducer: ReducerProtocol {
  public struct State: Equatable {}
  public enum Action: Equatable {
    case shortcutItem(UIApplicationShortcutItem)
  }

  public func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
    switch action {
    case .shortcutItem:
      return .none
    }
  }
}
