import SwiftUI
import AppFeature
import PhotoLibraryClientLive
import ComposableArchitecture

final class AppDelegate: NSObject, UIApplicationDelegate {
  let store = Store(
    initialState: AppReducer.State(),
    reducer: AppReducer().transformDependency(\.self) {
      $0.photoLibraryClient = .liveValue
    }
  )
  
  var viewStore: ViewStore<Void, AppReducer.Action> {
    return ViewStore(store.stateless)
  }
  
  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
  ) -> Bool {
    viewStore.send(.appDelegate(.didFinishLaunching))
    return true
  }
  
  func application(
    _ application: UIApplication,
    didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
  ) {
    self.viewStore.send(.appDelegate(.didRegisterForRemoteNotifications(.success(deviceToken))))
  }
  
  func application(
    _ application: UIApplication,
    didFailToRegisterForRemoteNotificationsWithError error: Error
  ) {
    self.viewStore.send(.appDelegate(.didRegisterForRemoteNotifications(.failure(error))))
  }
}

@main
struct CaptionApp: App {
  @UIApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
  
  var body: some Scene {
    WindowGroup {
      AppView(store: appDelegate.store)
    }
  }
}
