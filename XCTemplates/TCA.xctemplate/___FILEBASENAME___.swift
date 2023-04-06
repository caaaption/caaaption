import ComposableArchitecture
import SwiftUI

public struct ___VARIABLE_productName:identifier___Reducer: ReducerProtocol {
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

public struct ___VARIABLE_productName:identifier___View: View {
  let store: StoreOf<___VARIABLE_productName:identifier___Reducer>

  public init(store: StoreOf<___VARIABLE_productName:identifier___Reducer>) {
    self.store = store
  }

  public var body: some View {
    WithViewStore(store, observe: { $0 }) { _ in
    }
  }
}
