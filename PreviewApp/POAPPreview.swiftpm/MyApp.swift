import SwiftUI
import POAPWidgetFeature

@main
struct MyApp: App {
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
