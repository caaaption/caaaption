import SwiftUI
import ComposableArchitecture

public struct AppReducer: ReducerProtocol {
  public init() {}
  public struct State: Equatable {
    public init() {}
  }
  public enum Action: Equatable {
    case appDelegate(AppDelegateReducer.Action)
  }
  
  public var body: some ReducerProtocol<State, Action> {
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
    WithViewStore(store, observe: { $0 }) { viewStore in
      Text("AppView")
    }
  }
}
