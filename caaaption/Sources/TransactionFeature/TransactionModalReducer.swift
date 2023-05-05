import ComposableArchitecture

public struct TransactionModalReducer: ReducerProtocol {
  public init() {}

  public struct State: Equatable {
    public init() {}
  }

  public enum Action: Equatable {}

  public var body: some ReducerProtocol<State, Action> {
    Reduce { _, action in
      switch action {}
    }
  }
}
