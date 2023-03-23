import SwiftUI
import ComposableArchitecture

public struct FeedReducer: ReducerProtocol {
  public init() {}
  public struct State: Equatable {
    public var post = PostReducer.State()
    
    public init() {}
  }
  
  public enum Action: Equatable {
    case post(PostReducer.Action)
  }
  
  public var body: some ReducerProtocol<State, Action> {
    Scope(state: \.post, action: /Action.post) {
      PostReducer()
    }
  }
}

