import SwiftUI
import FeedFeature
import ComposableArchitecture

public struct MainTabReducer: ReducerProtocol {
  public init() {}
  
  public struct State: Equatable {
    public var feed = FeedReducer.State()
    public enum Tab: Equatable {
      case feed
      case mypage
    }
    public var tab = Tab.feed
    
    public init() {}
  }
  
  public enum Action: Equatable {
    case feed(FeedReducer.Action)
    case actionFeed
    case actionUpload
    case actionMypage
  }
  
  public func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
    switch action {
    case .feed:
      return EffectTask.none
      
    case .actionFeed:
      state.tab = .feed
      return EffectTask.none
      
    case .actionUpload:
      return EffectTask.none
      
    case .actionMypage:
      state.tab = .mypage
      return EffectTask.none
    }
  }
}

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
          actionUpload: { viewStore.send(.actionUpload) },
          actionMypage: { viewStore.send(.actionMypage) }
        )
      }
      .edgesIgnoringSafeArea(.bottom)
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
