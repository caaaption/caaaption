import ComposableArchitecture
import ContributorFeature
import SwiftUI

public struct AccountView: View {
  let store: StoreOf<AccountReducer>

  public init(store: StoreOf<AccountReducer>) {
    self.store = store
  }

  public var body: some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
      List {
        Section {
          Button("Privacy Policy", action: { viewStore.send(.privacyPolicy) })
        }
        Section {
          NavigationLink(
            destination: ContributorView(
              store: store.scope(
                state: \.contributor,
                action: AccountReducer.Action.contributor
              )
            ),
            label: {
              Text("Contributors")
            }
          )
        }
      }
      .navigationBarTitleDisplayMode(.inline)
      .navigationTitle("Account")
      .toolbar {
        ToolbarItem(placement: .navigationBarTrailing) {
          Button("Done", action: {
            viewStore.send(.dismiss)
          })
          .bold()
        }
      }
    }
  }
}

#if DEBUG
  import SwiftUIHelpers

  struct AccountViewPreviews: PreviewProvider {
    static var previews: some View {
      Preview {
        NavigationStack {
          AccountView(
            store: .init(
              initialState: AccountReducer.State(),
              reducer: AccountReducer()
            )
          )
        }
      }
    }
  }
#endif
