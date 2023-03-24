import SwiftUI
import ComposableArchitecture

public struct MainTabReducer: ReducerProtocol {
  public init() {}
  
  public struct State: Equatable {
    public enum Tab: Equatable {
      case feed
      case mypage
    }
    public var tab = Tab.feed
    
    public init() {}
  }
  
  public enum Action: Equatable {
    case actionFeed
    case actionUpload
    case actionMypage
  }
  
  public func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
    switch action {
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
        Group { () -> Text in
          switch viewStore.tab {
          case MainTabReducer.State.Tab.feed:
            return Text("Feed")
          case MainTabReducer.State.Tab.mypage:
            return Text("MyPage")
          }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        
        TabBarView(
          actionFeed: { viewStore.send(.actionFeed) },
          actionUpload: { viewStore.send(.actionUpload) },
          actionMypage: { viewStore.send(.actionMypage) }
        )
      }
      .edgesIgnoringSafeArea(.all)
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
