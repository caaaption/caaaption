import ComposableArchitecture
import ContributorFeature
import ServerConfig
import SwiftUI

public struct AccountReducer: ReducerProtocol {
  public init() {}

  public struct State: Equatable {
    public var contributor = ContributorReducer.State()
    public init() {}
  }

  public enum Action: Equatable {
    case contributor(ContributorReducer.Action)

    case privacyPolicyButtonTapped
    case dismissButtonTapped
  }

  @Dependency(\.openURL) var openURL
  @Dependency(\.dismiss) var dismiss

  public var body: some ReducerProtocol<State, Action> {
    Scope(state: \.contributor, action: /Action.contributor) {
      ContributorReducer()
    }
    Reduce { _, action in
      switch action {
      case .contributor:
        return .none

      case .privacyPolicyButtonTapped:
        return .run { _ in
          await self.openURL(ServerConfig.privacyPolicy)
        }
      case .dismissButtonTapped:
        return .run { _ in
          await self.dismiss()
        }
      }
    }
  }
}

public struct AccountView: View {
  let store: StoreOf<AccountReducer>

  public init(store: StoreOf<AccountReducer>) {
    self.store = store
  }

  public var body: some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
      List {
        Section {
          Button("Privacy Policy") {
            viewStore.send(.privacyPolicyButtonTapped)
          }
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
          Button("Done") {
            viewStore.send(.dismissButtonTapped)
          }
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
