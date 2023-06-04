import SwiftUI
import POAPWidgetFeature

@main
struct MyApp: App {
  var body: some Scene {
    WindowGroup {
      MyPOAPView(
        store: .init(
          initialState: MyPOAPReducer.State(),
          reducer: MyPOAPReducer()._printChanges()
        )
      )
    }
  }
}
