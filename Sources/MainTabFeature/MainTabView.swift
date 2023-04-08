import ComposableArchitecture
import FeedFeature
import ProfileFeature
import SwiftUI
import UploadFeature

public struct MainTabView: View {
  let store: StoreOf<MainTabReducer>

  public init(
    store: StoreOf<MainTabReducer>
  ) {
    self.store = store
  }

  public var body: some View {
    WithViewStore(store) { viewStore in
      ZStack(alignment: .bottom) {
        Group {
          if viewStore.tab == MainTabReducer.State.Tab.feed {
            FeedView(
              store: store.scope(
                state: \.feed,
                action: MainTabReducer.Action.feed
              )
            )
          } else {
            ProfileView(
              store: store.scope(
                state: \.profile,
                action: MainTabReducer.Action.profile
              )
            )
          }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)

        TabBarView(
          actionFeed: { viewStore.send(.actionFeed) },
          actionUpload: { viewStore.send(.binding(.set(\.$contentTypeModalPresented, true))) },
          actionMypage: { viewStore.send(.actionMypage) }
        )
      }
      .edgesIgnoringSafeArea(.bottom)
      .sheet(isPresented: viewStore.binding(\.$uploadPresented)) {
        UploadView(
          store: store.scope(
            state: \.upload,
            action: MainTabReducer.Action.upload
          )
        )
      }
      .sheet(isPresented: viewStore.binding(\.$contentTypeModalPresented)) {
        ContentTypeModalView(
          store: store.scope(
            state: \.contentTypeModal,
            action: MainTabReducer.Action.contentTypeModal
          )
        )
        .presentationDetents([.medium])
      }
    }
  }
}

struct MainTabViewPreview: PreviewProvider {
  static var previews: some View {
    MainTabView(
      store: .init(
        initialState: MainTabReducer.State(),
        reducer: MainTabReducer()
      )
    )
  }
}
