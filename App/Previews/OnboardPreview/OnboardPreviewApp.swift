import SwiftUI
import OnboardFeature
import ComposableArchitecture

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
