import ComposableArchitecture
import SwiftUI

public struct ConnectWithWalletReducer: ReducerProtocol {
  public init() {}

  public struct State: Equatable {
    public var signInEthereum = SignInEthereumReducer.State()
    public init() {}
  }

  public enum Action: Equatable {
    case signInEthereum(SignInEthereumReducer.Action)
  }

  public var body: some ReducerProtocol<State, Action> {
    Scope(state: \.signInEthereum, action: /Action.signInEthereum) {
      SignInEthereumReducer()
    }
  }
}

public struct ConnectWithWalletView: View {
  let store: StoreOf<ConnectWithWalletReducer>

  public init(store: StoreOf<ConnectWithWalletReducer>) {
    self.store = store
  }

  public var body: some View {
    WithViewStore(store, observe: { $0 }) { _ in
      ScrollView(.vertical) {
        VStack(spacing: 24) {
          Text("Connect with\nwallet")
            .multilineTextAlignment(.center)
            .font(.largeTitle)
            .bold()

          Text("We found the following options based on compatibility with caaaption.")
            .multilineTextAlignment(.center)
            .foregroundColor(.secondary)

          VStack(spacing: 12) {
            NavigationLink {
              SignInEthereumView(
                store: store.scope(
                  state: \.signInEthereum,
                  action: ConnectWithWalletReducer.Action.signInEthereum
                )
              )
            } label: {
              WalletAppButton(appName: "Connect via Desktop")
            }
            WalletAppButton(appName: "1inch Wallet")
            WalletAppButton(appName: "Argent")
            WalletAppButton(appName: "MetaMask")
            WalletAppButton(appName: "Rainbow")
            WalletAppButton(appName: "Safe")
            WalletAppButton(appName: "Spot")
            WalletAppButton(appName: "Uniswap Wallet")
            WalletAppButton(appName: "Coinbase")
            WalletAppButton(appName: "Ledger Live")
          }
          .padding(.horizontal, 20)
        }
      }
    }
  }
}

struct WalletAppButton: View {
  let appName: String

  var body: some View {
    HStack(spacing: 12) {
      Color.red
        .frame(width: 41, height: 41)
        .cornerRadius(8)
        .padding(.leading, 12)

      VStack(alignment: .leading, spacing: 0) {
        Text(appName)
        Text("App installed")
          .foregroundColor(Color.blue)
      }

      Spacer()
    }
    .frame(height: 62)
    .frame(maxWidth: .infinity)
    .background(Color(uiColor: .quaternarySystemFill))
    .cornerRadius(8)
  }
}

#if DEBUG
  struct ConnectWithWalletViewPreviews: PreviewProvider {
    static var previews: some View {
      ConnectWithWalletView(
        store: .init(
          initialState: ConnectWithWalletReducer.State(),
          reducer: ConnectWithWalletReducer()
        )
      )
    }
  }
#endif
