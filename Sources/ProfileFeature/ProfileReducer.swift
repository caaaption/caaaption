import ComposableArchitecture

public struct ProfileReducer: ReducerProtocol {
  public init() {}

  public struct State: Equatable {
    public var header = HeaderReducer.State()
    public init() {}
  }

  public enum Action: Equatable {
    case header(HeaderReducer.Action)
  }

  public var body: some ReducerProtocol<State, Action> {
    Scope(state: \.header, action: /Action.header) {
      HeaderReducer()
    }
  }
}
