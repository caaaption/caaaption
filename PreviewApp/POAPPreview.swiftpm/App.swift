import SwiftUI
import POAPWidgetFeature

@main
struct App: SwiftUI.App {
  var body: some Scene {
    WindowGroup {
      NavigationStack {
        MyPOAPView(
          store: .init(
            initialState: MyPOAPReducer.State(),
            reducer: MyPOAPReducer()._printChanges()
          )
        )
      }
    }
  }
}
