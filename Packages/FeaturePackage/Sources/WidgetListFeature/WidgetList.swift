import ComposableArchitecture
import SwiftUI

public struct WidgetListReducer: ReducerProtocol {
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
          return .none
      }
    }
  }
}

public struct WidgetListView: View {
  let store: StoreOf<WidgetListReducer>

  public init(store: StoreOf<WidgetListReducer>) {
    self.store = store
  }
  
  static let colors: [Color] = [.red, .blue, .purple, .yellow, .black, .indigo, .cyan, .brown, .mint, .orange]

  public var body: some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
      LazyVGrid(
        columns: Array(repeating: GridItem(), count: 2),
        spacing: 12
      ) {
        ForEach(
          Self.colors,
          id: \.self
        ) { color in
          color
        }
      }
    }
  }
}

#if DEBUG
  struct WidgetListViewPreviews: PreviewProvider {
    static var previews: some View {
      WidgetListView(
        store: .init(
          initialState: WidgetListReducer.State(),
          reducer: WidgetListReducer()
        )
      )
    }
  }
#endif
