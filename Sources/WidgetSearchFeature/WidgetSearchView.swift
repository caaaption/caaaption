import ComposableArchitecture
import SwiftUI

public struct WidgetSearchView: View {
  let store: StoreOf<WidgetSearchReducer>

  public init(store: StoreOf<WidgetSearchReducer>) {
    self.store = store
  }

  public var body: some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
      List {
        ForEach(0 ..< 10) { _ in
          VStack(spacing: 12) {
            HStack(spacing: 12) {
              Color.red
                .frame(width: 62, height: 62)
                .cornerRadius(12)

              VStack(alignment: .leading, spacing: 0) {
                Text("Check your balance")
                  .bold()
                Text("QuickNode")
                  .foregroundColor(.secondary)
              }

              Spacer()

              Button("Install", action: {})
                .foregroundColor(.blue)
                .bold()
            }
          }
          .listRowSeparator(.hidden)
        }
      }
      .listStyle(.plain)
      .navigationTitle("Widget Search")
      .task { await viewStore.send(.task).finish() }
      .refreshable { await viewStore.send(.refreshable).finish() }
      .searchable(
        text: viewStore.binding(\.$searchable),
        placement: .navigationBarDrawer(
          displayMode: .always
        ),
        prompt: "Search Widget"
      )
    }
  }
}

#if DEBUG
import SwiftUIHelpers

struct WidgetSearchViewPreviews: PreviewProvider {
  static var previews: some View {
    Preview {
      NavigationStack {
        WidgetSearchView(
          store: .init(
            initialState: WidgetSearchReducer.State(),
            reducer: WidgetSearchReducer()
          )
        )
      }
    }
  }
}
#endif
