import GalleryFeature
import SwiftUI

@main
struct App: SwiftUI.App {
  var body: some Scene {
    WindowGroup {
      GalleryView(
        store: .init(
          initialState: GalleryReducer.State(),
          reducer: GalleryReducer()._printChanges()
        )
      )
    }
  }
}
