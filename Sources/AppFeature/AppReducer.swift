import SwiftUI
import MainTabFeature
import ComposableArchitecture

public struct AppReducer: ReducerProtocol {
  public init() {}
  
  public struct State: Equatable {
    public init() {}
    
    public var tab = MainTabReducer.State()
  }
  public enum Action: Equatable {
    case appDelegate(AppDelegateReducer.Action)
    case tab(MainTabReducer.Action)
  }
  
  public var body: some ReducerProtocol<State, Action> {
    Scope(state: \.tab, action: /Action.tab) {
      MainTabReducer()
    }
    Reduce { state, action in
      switch action {
      default:
        return EffectTask.none
      }
    }
  }
}

public struct AppView: View {
  let store: StoreOf<AppReducer>
  
  public init(store: StoreOf<AppReducer>) {
    self.store = store
  }
  
  public var body: some View {
    MainTabView(store: self.store.scope(state: \.tab, action: AppReducer.Action.tab))
  }
}
