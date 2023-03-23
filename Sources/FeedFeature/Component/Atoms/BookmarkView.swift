import SwiftUI
import ComposableArchitecture

public struct BookmarkReducer: ReducerProtocol {
  public struct State: Equatable {
    public var isBookmarked = false
  }
  
  public enum Action: Equatable {
    case action
  }
  
  public func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
    switch action {
    case .action:
      state.isBookmarked.toggle()
      return EffectTask.none
    }
  }
}

public struct BookmarkView: View {
  let store: StoreOf<BookmarkReducer>
  
  public init(store: StoreOf<BookmarkReducer>) {
    self.store = store
  }
  
  public var body: some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
      Button(
        action: { viewStore.send(.action) },
        label: {
          Image(
            systemName: viewStore.isBookmarked ? "bookmark.fill" : "bookmark"
          )
          .accentColor(Color.primary)
        }
      )
    }
  }
}

struct BookmarkViewPreview: PreviewProvider {
  static var previews: some View {
    HStack {
      BookmarkView(
        store: Store(
          initialState: BookmarkReducer.State(),
          reducer: BookmarkReducer()
        )
      )
      BookmarkView(
        store: Store(
          initialState: BookmarkReducer.State(
            isBookmarked: true
          ),
          reducer: BookmarkReducer()
        )
      )
    }
    .previewLayout(.sizeThatFits)
  }
}
