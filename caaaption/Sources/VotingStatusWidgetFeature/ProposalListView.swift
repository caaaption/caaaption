import ComposableArchitecture
import SwiftUI

public struct ProposalListView: View {
  let store: StoreOf<ProposalListReducer>

  public init(store: StoreOf<ProposalListReducer>) {
    self.store = store
  }

  public var body: some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
      List {
        ForEach(viewStore.proposals, id: \.self) { proposal in
          ProposalCard(proposal: proposal)
        }
      }
      .listStyle(.plain)
      .navigationTitle("Proposals")
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

  struct ProposalListViewPreviews: PreviewProvider {
    static var previews: some View {
      Preview {
        NavigationStack {
          ProposalListView(
            store: .init(
              initialState: ProposalListReducer.State(),
              reducer: ProposalListReducer()
            )
          )
        }
      }
    }
  }
#endif
