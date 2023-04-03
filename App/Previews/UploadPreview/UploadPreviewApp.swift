import ComposableArchitecture
import PhotoLibraryClientLive
import SwiftUI
import UploadFeature

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
