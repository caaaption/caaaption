import OnboardFeature
import SwiftUI

@main
struct App: SwiftUI.App {
  var body: some Scene {
    WindowGroup {
      NavigationStack {
        WelcomeView(
          store: .init(
            initialState: WelcomeReducer.State(),
            reducer: WelcomeReducer()._printChanges()
          )
        )
      }
    }
  }
}
