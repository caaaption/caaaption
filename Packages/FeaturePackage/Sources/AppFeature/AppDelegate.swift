import ComposableArchitecture
import UIKit

public struct AppDelegateReducer: ReducerProtocol {
  public struct State: Equatable {}
  public enum Action: Equatable {
    case didFinishLaunching
    case didRegisterForRemoteNotifications(TaskResult<Data>)
    case configurationForConnecting(UIApplicationShortcutItem?)
    case quickAction(QuickActionReducer.Action)
  }

  public func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
    switch action {
    case .didFinishLaunching:
      return EffectTask.none
    case .didRegisterForRemoteNotifications(.failure):
      return EffectTask.none
    case let .didRegisterForRemoteNotifications(.success(tokenData)):
      let token = tokenData.map { String(format: "%02.2hhx", $0) }.joined()
      print("didRegisterForRemoteNotifications : \(token)")
      return EffectTask.none
    case let .configurationForConnecting(shortcutItem):
      if let shortcutItem {
        return .run { send in
          await send(.quickAction(.quickAction(shortcutItem)))
        }
      }
      return .none
    case .quickAction:
      return .none
    }
  }
}
