import ComposableArchitecture
import SwiftUI

public struct MyPOAPReducer: ReducerProtocol {
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

public struct MyPOAPView: View {
  let store: StoreOf<MyPOAPReducer>

  public init(store: StoreOf<MyPOAPReducer>) {
    self.store = store
  }

  public var body: some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
      List {
        Text("MyPOAP")
      }
      .navigationTitle("MyPOAP")
      .navigationBarTitleDisplayMode(.inline)
      .task { await viewStore.send(.task).finish() }
    }
  }
}

#if DEBUG
  struct MyPOAPViewPreviews: PreviewProvider {
    static var previews: some View {
      MyPOAPView(
        store: .init(
          initialState: MyPOAPReducer.State(),
          reducer: MyPOAPReducer()
        )
      )
    }
  }
#endif
