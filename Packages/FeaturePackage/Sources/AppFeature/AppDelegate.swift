import AnalyticsClient
import Build
import ComposableArchitecture
import FirebaseCoreClient
import UIKit

public struct AppDelegateReducer: ReducerProtocol {
  public struct State: Equatable {}
  public enum Action: Equatable {
    case didFinishLaunching
    case didRegisterForRemoteNotifications(TaskResult<Data>)
    case configurationForConnecting(UIApplicationShortcutItem?)
  }

  @Dependency(\.firebaseCore) var firebaseCore
  @Dependency(\.build.bundleIdentifier) var bundleIdentifier
  @Dependency(\.analytics.setAnalyticsCollectionEnabled) var setAnalyticsCollectionEnabled

  public func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
    switch action {
    case .didFinishLaunching:
      print("didFinishLaunching")
      let isStaging = bundleIdentifier() == "com.caaaption-staging"
      return .run { _ in
        self.firebaseCore.configure()
        self.setAnalyticsCollectionEnabled(isStaging)
      } catch: { error, _ in
        print(error)
      }

    case .didRegisterForRemoteNotifications(.failure):
      return .none

    case let .didRegisterForRemoteNotifications(.success(tokenData)):
      let token = tokenData.map { String(format: "%02.2hhx", $0) }.joined()
      print("didRegisterForRemoteNotifications : \(token)")
      return .none

    case .configurationForConnecting:
      return .none
    }
  }
}
