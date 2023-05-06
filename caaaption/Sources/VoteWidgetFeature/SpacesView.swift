import ComposableArchitecture
import SwiftUI

func formatNumber(_ number: Int) -> String {
  if number >= 1000 {
    let num = Double(number) / 1000.0
    return String(format: "%.1fK members", num)
  } else {
    return "\(number) members"
  }
}

public struct SpacesView: View {
  let store: StoreOf<SpacesReducer>

  public init(store: StoreOf<SpacesReducer>) {
    self.store = store
  }

  public var body: some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
      List {
        ForEach(viewStore.spaces, id: \.id) { space in
          Text(space.name ?? space.id)
            .badge(formatNumber(space.followersCount ?? 0))
        }
      }
      .navigationTitle("Spaces")
      .navigationBarTitleDisplayMode(.inline)
      .task { await viewStore.send(.task).finish() }
      .toolbar {
        ToolbarItem(placement: .navigationBarTrailing) {
          Button {
            viewStore.send(.dismiss)
          } label: {
            Image(systemName: "xmark.circle.fill")
              .symbolRenderingMode(.palette)
              .foregroundStyle(.gray, .bar)
              .font(.system(size: 30))
          }
        }
      }
    }
  }
}
