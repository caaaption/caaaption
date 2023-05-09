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
          Button {
            viewStore.send(.tappedSpace(space))
          } label: {
            Text(space.value.name ?? space.value.id)
              .badge(formatNumber(space.value.followersCount ?? 0))
          }
        }
        .navigationDestination(
          store: store.scope(
            state: \.$selection,
            action: SpacesReducer.Action.selection
          ),
          destination: ProposalsView.init(store:)
        )
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
