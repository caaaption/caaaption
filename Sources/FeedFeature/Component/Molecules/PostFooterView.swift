import SwiftUI
import ComposableArchitecture

public struct PostFooterReducer: ReducerProtocol {
  public struct State: Equatable {
    var bookmark = BookmarkReducer.State()
  }
  public enum Action: Equatable {
    case bookmark(BookmarkReducer.Action)
  }
  
  public var body: some ReducerProtocol<State, Action> {
    Scope(state: \.bookmark, action: /Action.bookmark) {
      BookmarkReducer()
    }
  }
}

public struct PostFooterView: View {
  let store: StoreOf<PostFooterReducer>
  
  public init(store: StoreOf<PostFooterReducer>) {
    self.store = store
  }
  
  public var body: some View {
    HStack {
      Spacer()
      BookmarkView(store: store.scope(state: \.bookmark, action: PostFooterReducer.Action.bookmark))
    }
  }
}
