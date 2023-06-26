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
      return .none

    case .didRegisterForRemoteNotifications(.failure):
      return .none

    case let .didRegisterForRemoteNotifications(.success(tokenData)):
      let token = tokenData.map { String(format: "%02.2hhx", $0) }.joined()
      print("didRegisterForRemoteNotifications : \(token)")
      return .none

    case let .configurationForConnecting(.some(shortcutItem)):
      return .run { send in
        await send(.quickAction(.quickAction(shortcutItem)))
      }

    case .configurationForConnecting:
      return .none

    case .quickAction:
      return .none
    }
  }
}
