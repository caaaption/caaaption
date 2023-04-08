import CollectionFeature
import ComposableArchitecture

public struct ProfileReducer: ReducerProtocol {
  public init() {}

  public struct State: Equatable {
    public var header = HeaderReducer.State()
    public var collection = CollectionReducer.State()
    public init() {}
  }

  public enum Action: Equatable {
    case header(HeaderReducer.Action)
    case collection(CollectionReducer.Action)
  }

  public var body: some ReducerProtocol<State, Action> {
    Scope(state: \.header, action: /Action.header) {
      HeaderReducer()
    }
    Scope(state: \.collection, action: /Action.collection) {
      CollectionReducer()
    }
  }
}
