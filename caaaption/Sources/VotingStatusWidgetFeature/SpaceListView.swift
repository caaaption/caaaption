import ComposableArchitecture
import SwiftUI

public struct SpaceListView: View {
  let store: StoreOf<SpaceListReducer>

  public init(store: StoreOf<SpaceListReducer>) {
    self.store = store
  }

  public var body: some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
      List {
        ForEach(viewStore.spaces, id: \.id) { space in
          NavigationLink(
            destination: IfLetStore(
              store.scope(
                state: \.selection?.value,
                action: SpaceListReducer.Action.proposals
              ),
              then: ProposalListView.init(store:),
              else: ProgressView.init
            ),
            tag: space.id,
            selection: viewStore.binding(
              get: \.selection?.id,
              send: SpaceListReducer.Action.setNavigation(id:)
            ),
            label: {
              SpaceCard(name: space.name ?? "", followersCount: space.followersCount ?? 0)
            }
          )
        }
      }
      .listStyle(.plain)
      .navigationTitle("Spaces")
      .task { await viewStore.send(.task).finish() }
      .refreshable { await viewStore.send(.refreshable).finish() }
      .searchable(
        text: viewStore.binding(\.$searchable),
        placement: .navigationBarDrawer(
          displayMode: .always
        ),
        prompt: "Search Space"
      )
    }
  }
}

#if DEBUG
  import SwiftUIHelpers

  struct SpaceListViewPreviews: PreviewProvider {
    static var previews: some View {
      Preview {
        NavigationStack {
          SpaceListView(
            store: .init(
              initialState: SpaceListReducer.State(),
              reducer: SpaceListReducer()
            )
          )
        }
      }
    }
  }
#endif
