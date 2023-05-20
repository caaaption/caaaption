import OnboardFeature
import SwiftUI

@main
struct OnboardPreviewApp: App {
  var body: some Scene {
    WindowGroup {
      NavigationStack {
        WelcomeView(
          store: .init(
            initialState: WelcomeReducer.State(),
            reducer: WelcomeReducer()
          )
        )
      }
    }
  }
}
