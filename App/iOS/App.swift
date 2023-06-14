import AppFeature
import ComposableArchitecture
import QuickNodeClient
import SwiftUI
import UserDefaultsClient
import WidgetClient

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  func windowScene(
    _ windowScene: UIWindowScene,
    performActionFor shortcutItem: UIApplicationShortcutItem,
    completionHandler: @escaping (Bool) -> Void
  ) {
    AppDelegate.shared.viewStore.send(.sceneDelegate(.shortcutItem(shortcutItem)))
    completionHandler(true)
  }
}

final class AppDelegate: NSObject, UIApplicationDelegate {
  static let shared = AppDelegate()
  let store = Store(
    initialState: AppReducer.State(),
    reducer: AppReducer().transformDependency(\.self) {
      $0.quickNodeClient = .liveValue
      $0.userDefaults = .liveValue
      $0.widgetClient = .liveValue
    }._printChanges()
  )

  var viewStore: ViewStore<Void, AppReducer.Action> {
    return ViewStore(store.stateless)
  }

  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
  ) -> Bool {
    viewStore.send(.appDelegate(.didFinishLaunching))

    return true
  }

  func application(
    _ application: UIApplication,
    didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
  ) {
    viewStore.send(.appDelegate(.didRegisterForRemoteNotifications(.success(deviceToken))))
  }

  func application(
    _ application: UIApplication,
    didFailToRegisterForRemoteNotificationsWithError error: Error
  ) {
    viewStore.send(.appDelegate(.didRegisterForRemoteNotifications(.failure(error))))
  }
  
  func application(
    _ application: UIApplication,
    configurationForConnecting connectingSceneSession: UISceneSession,
    options: UIScene.ConnectionOptions
  ) -> UISceneConfiguration {
    let config = UISceneConfiguration(
      name: connectingSceneSession.configuration.name,
      sessionRole: connectingSceneSession.role
    )
    config.delegateClass = SceneDelegate.self
    return config
  }
}

@main
struct CaaaptionApp: App {
  @UIApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate

  var body: some Scene {
    WindowGroup {
      AppView(store: appDelegate.store)
    }
  }
}
