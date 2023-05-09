import ComposableArchitecture
import SwiftUI

public struct ProposalsView: View {
  let store: StoreOf<ProposalsReducer>

  public init(store: StoreOf<ProposalsReducer>) {
    self.store = store
  }

  public var body: some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
      List {
        ForEach(viewStore.proposals) { proposal in
          Button {
            print("tapped proposal")
          } label: {
            Text(proposal.value.title)
          }
        }
      }
      .navigationTitle("Proposals")
      .navigationBarTitleDisplayMode(.inline)
    }
  }
}
