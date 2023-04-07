import ACarousel
import ComposableArchitecture
import ContentFeature
import SwiftUI

public struct FeedView: View {
  let store: StoreOf<FeedReducer>

  public init(store: StoreOf<FeedReducer>) {
    self.store = store
  }

  public var body: some View {
    ACarousel(
      [0, 1, 2, 3, 4, 5, 6, 7, 8, 9],
      id: \.self,
      headspace: 24,
      sidesScaling: 1
    ) { _ in
      ContentView(store: store.scope(state: \.content, action: FeedReducer.Action.content))
    }
    .edgesIgnoringSafeArea(.all)
  }
}

struct FeedViewPreviews: PreviewProvider {
  static var previews: some View {
    FeedView(
      store: .init(
        initialState: FeedReducer.State(),
        reducer: FeedReducer()
      )
    )
  }
}
