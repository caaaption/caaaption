import SwiftUI
import FeedFeature
import UploadFeature
import ComposableArchitecture

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
            FeedView(store: store.scope(state: \.feed, action: MainTabReducer.Action.feed))
          } else {
            Text("MyPage")
          }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        
        TabBarView(
          actionFeed: { viewStore.send(.actionFeed) },
          actionUpload: { viewStore.send(.setSheet(isPresented: true) )},
          actionMypage: { viewStore.send(.actionMypage) }
        )
      }
      .edgesIgnoringSafeArea(.bottom)
      .sheet(
        isPresented: viewStore.binding(
          get: \.isSheetPresented,
          send: MainTabReducer.Action.setSheet(isPresented:)
        ),
        content: {
          UploadView(store: store.scope(state: \.upload, action: MainTabReducer.Action.upload))
        }
      )
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
