import ComposableArchitecture
import ContributorFeature
import ServerConfig
import SwiftUI
import UIApplicationClient

public struct AccountReducer: ReducerProtocol {
  public init() {}

  public struct State: Equatable {
    public var contributor = ContributorReducer.State()
    public init() {}
  }

  public enum Action: Equatable {
    case contributor(ContributorReducer.Action)

    case privacyPolicy
    case dismiss
  }

  @Dependency(\.applicationClient.open) var openURL
  @Dependency(\.dismiss) var dismiss

  public var body: some ReducerProtocol<State, Action> {
    Scope(state: \.contributor, action: /Action.contributor) {
      ContributorReducer()
    }
    Reduce { _, action in
      switch action {
      case .contributor:
        return EffectTask.none

      case .privacyPolicy:
        return .fireAndForget {
          _ = await self.openURL(
            ServerConfig.privacyPolicy,
            [:]
          )
        }
      case .dismiss:
        return EffectTask.fireAndForget {
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
