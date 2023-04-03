import ComposableArchitecture
import OnboardFeature
import SwiftUI

@main
struct OnboardPreviewApp: App {
  var body: some Scene {
    WindowGroup {
      LaunchView(
        store: .init(
          initialState: OnboardReducer.State(),
          reducer: OnboardReducer()
        )
      )
    }
  }
}
