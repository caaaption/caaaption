import SwiftUI
import ContentFeature
import ComposableArchitecture

public struct FeedReducer: ReducerProtocol {
  public init() {}
  public struct State: Equatable {
    public var content = ContentReducer.State()
    
    public init() {}
  }
  
  public enum Action: Equatable {
    case content(ContentReducer.Action)
  }
  
  public var body: some ReducerProtocol<State, Action> {
    Scope(state: \.content, action: /Action.content) {
      ContentReducer()
    }
  }
}

