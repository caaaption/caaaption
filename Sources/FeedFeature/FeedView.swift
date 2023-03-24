import SwiftUI
import ContentFeature
import ComposableArchitecture

public struct FeedView: View {
  let store: StoreOf<FeedReducer>
  
  public init(store: StoreOf<FeedReducer>) {
    self.store = store
  }
  
  public var body: some View {
    ContentView(store: store.scope(state: \.content, action: FeedReducer.Action.content))
  }
}
