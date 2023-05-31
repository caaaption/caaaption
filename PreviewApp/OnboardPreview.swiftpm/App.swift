import OnboardFeature
import SwiftUI

@main
struct App: SwiftUI.App {
  var body: some Scene {
    WindowGroup {
      OnboardView(
        store: .init(
          initialState: OnboardReducer.State(),
          reducer: OnboardReducer()._printChanges()
        )
      )
    }
  }
}
