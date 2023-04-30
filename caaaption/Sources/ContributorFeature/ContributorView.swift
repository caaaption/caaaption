import PlaceholderAsyncImage
import ComposableArchitecture
import SwiftUI

public struct ContributorView: View {
  let store: StoreOf<ContributorReducer>

  public init(store: StoreOf<ContributorReducer>) {
    self.store = store
  }

  public var body: some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
      List(viewStore.contributors) { contributor in
        Button {
          viewStore.send(.tappendContributor(contributor.id))
        } label: {
          HStack(alignment: .center, spacing: 12) {
            PlaceholderAsyncImage(
              url: URL(string: contributor.avatarUrl)
            )
            .frame(width: 44, height: 44)
            .clipShape(Circle())
            
            Text(contributor.login)
              .bold()
          }
          .frame(height: 68)
        }
      }
      .navigationTitle("Contributors")
      .task { await viewStore.send(.task).finish() }
      .refreshable { await viewStore.send(.refreshable).finish() }
    }
  }
}

#if DEBUG
import SwiftUIHelpers

struct ContributorViewPreviews: PreviewProvider {
  static var previews: some View {
    ContributorView(
      store: .init(
        initialState: ContributorReducer.State(),
        reducer: ContributorReducer()
      )
    )
  }
}
#endif
