import ComposableArchitecture
import SwiftUI

public struct ___VARIABLE_productName:identifier___Reducer: ReducerProtocol {
  public init() {}

  public struct State: Equatable {
    public init() {}
  }

  public enum Action: Equatable {
    case onTask
  }

  public var body: some ReducerProtocol<State, Action> {
    Reduce { _, action in
      switch action {
        case .onTask:
          return EffectTask.none
      }
    }
  }
}

public struct ___VARIABLE_productName:identifier___View: View {
  let store: StoreOf<___VARIABLE_productName:identifier___Reducer>

  public init(store: StoreOf<___VARIABLE_productName:identifier___Reducer>) {
    self.store = store
  }

  public var body: some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
      List {
        Text("___VARIABLE_productName:identifier___")
      }
      .navigationTitle("___VARIABLE_productName:identifier___")
      .navigationBarTitleDisplayMode(.inline)
      .task { await viewStore.send(.onTask).finish() }
    }
  }
}

#if DEBUG
  struct ___VARIABLE_productName:identifier___ViewPreviews: PreviewProvider {
    static var previews: some View {
      ___VARIABLE_productName:identifier___View(
        store: .init(
          initialState: ___VARIABLE_productName:identifier___Reducer.State(),
          reducer: ___VARIABLE_productName:identifier___Reducer()
        )
      )
    }
  }
#endif