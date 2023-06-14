import ComposableArchitecture
import ContributorFeature
import PlaceholderAsyncImage
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
        return .run { _ in
          _ = await self.openURL(
            ServerConfig.privacyPolicy,
            [:]
          )
        }
      case .dismiss:
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
          HStack(spacing: 8) {
            PlaceholderAsyncImage(
              url: URL(
                string: "https://i.seadn.io/gae/c_u0e9m4wH4zgsJowfOOHd-EkQEzuxiEUZTsUsEbcc-sSJgmGX6uHMRX8pMgC6OQbfJ987nrF0-CSwGaBDQuS1tAe2w7B0eaAEj_?w=500&auto=format"
              )
            )
            .frame(width: 56, height: 56)
            .clipShape(Circle())

            VStack(alignment: .leading, spacing: 4) {
              Text("tomokisun.eth")
                .bold()

              Text("0x4F724516242829DC5Bc6119f666b18102437De53")
                .foregroundColor(.secondary)
                .font(.caption)
            }
          }
        }

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
