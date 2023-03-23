import SwiftUI
import DesignSystem
import ComposableArchitecture

public struct PostReducer: ReducerProtocol {
  public struct State: Equatable {
    var footer = PostFooterReducer.State()
  }
  public enum Action: Equatable {
    case footer(PostFooterReducer.Action)
  }
  
  public var body: some ReducerProtocol<State, Action> {
    Scope(state: \.footer, action: /Action.footer) {
      PostFooterReducer()
    }
  }
}

public struct PostView: View {
  let store: StoreOf<PostReducer>
  
  public init(store: StoreOf<PostReducer>) {
    self.store = store
  }
  
  public var body: some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
      VStack(spacing: 8) {
        PostHeaderView(avatarUrlString: "https://pbs.twimg.com/profile_images/1528599200132259841/G1fUHZQ9_400x400.jpg")
        
        ProgressAsyncImage(
          imageUrlString: "https://i.seadn.io/gae/zj6BbkqpaY4wTxQVSizvefxi70yZFZr-4J8UyGOcZDjXSy4A5IZSe7Shutw2QM5feSsEWnnGxMMSPNWYCz8YJCOOicMkFriHK7PQrw?auto=format&w=1000",
          radius: 16
        )
        
        PostFooterView(store: store.scope(state: \.footer, action: PostReducer.Action.footer))
      }
    }
  }
}

struct PostViewPreview: PreviewProvider {
  static var previews: some View {
    PostView(
      store: Store(
        initialState: PostReducer.State(),
        reducer: PostReducer()
      )
    )
    .padding()
    .previewLayout(.sizeThatFits)
  }
}
