import ComposableArchitecture
import SwiftUI

public struct ContentReducer: ReducerProtocol {
  public init() {}

  public struct State: Equatable {
    public init() {}
  }

  public enum Action: Equatable {}

  public func reduce(into state: inout State, action: Action) -> EffectTask<Action> {}
}
