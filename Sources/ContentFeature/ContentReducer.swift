import ComposableArchitecture
import SwiftUI

public struct ContentReducer: ReducerProtocol {
  public init() {}

  public struct State: Equatable {
    @BindingState public var offset = CGPoint.zero
    public init() {}
  }

  public enum Action: BindableAction, Equatable {
    case binding(BindingAction<State>)
  }

  public var body: some ReducerProtocol<State, Action> {
    BindingReducer()
  }
}
