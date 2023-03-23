import SwiftUI
import ComposableArchitecture

public struct FeedView: View {
  let store: StoreOf<FeedReducer>
  
  public init(store: StoreOf<FeedReducer>) {
    self.store = store
  }
  
  public var body: some View {
    List {
      PostView(store: store.scope(state: \.post, action: FeedReducer.Action.post))
    }
    .listStyle(.plain)
  }
}
