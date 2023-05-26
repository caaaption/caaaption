import ComposableArchitecture
import SwiftUI

public struct GasPriceReducer: ReducerProtocol {
  public init() {}

  public struct State: Equatable {
    public init() {}
  }

  public enum Action: Equatable {
    case task
  }

  public var body: some ReducerProtocol<State, Action> {
    Reduce { _, action in
      switch action {
        case .task:
          return EffectTask.none
      }
    }
  }
}

public struct GasPriceView: View {
  let store: StoreOf<GasPriceReducer>

  public init(store: StoreOf<GasPriceReducer>) {
    self.store = store
  }

  public var body: some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
      List {
        Text("GasPrice")
      }
      .navigationTitle("GasPrice")
      .navigationBarTitleDisplayMode(.inline)
      .task { await viewStore.send(.task).finish() }
    }
  }
}

#if DEBUG
  struct GasPriceViewPreviews: PreviewProvider {
    static var previews: some View {
      GasPriceView(
        store: .init(
          initialState: GasPriceReducer.State(),
          reducer: GasPriceReducer()
        )
      )
    }
  }
#endif
