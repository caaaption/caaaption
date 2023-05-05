import ComposableArchitecture
import SwiftUI

public struct SpacesView: View {
  let store: StoreOf<SpacesReducer>

  public init(store: StoreOf<SpacesReducer>) {
    self.store = store
  }

  public var body: some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
      List {
        ForEach(viewStore.spaces, id: \.id) { space in
          Text(space.id)
        }
      }
      .task { await viewStore.send(.task).finish() }
    }
  }
}
