import SwiftUI
import UploadFeature
import PhotoLibraryClientLive
import ComposableArchitecture

@main
struct UploadPreviewApp: App {
  var body: some Scene {
    WindowGroup {
      UploadView(
        store: .init(
          initialState: UploadReducer.State(),
          reducer: UploadReducer()
            .dependency(\.photoLibraryClient, .liveValue)
        )
      )
    }
  }
}
