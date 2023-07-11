import ComposableArchitecture
import SwiftUI

public struct SignInEthereumReducer: ReducerProtocol {
  public init() {}

  public struct State: Equatable {
    var signInButton = SignInButtonReducer.State()
    public init() {}
  }

  public enum Action: Equatable {
    case signInButton(SignInButtonReducer.Action)

    case onTask
  }

  public var body: some ReducerProtocol<State, Action> {
    Scope(state: \.signInButton, action: /Action.signInButton) {
      SignInButtonReducer()
    }
    Reduce { _, action in
      switch action {
      case .signInButton:
        return .none

      case .onTask:
        return .none
      }
    }
  }
}

public struct SignInEthereumView: View {
  let store: StoreOf<SignInEthereumReducer>

  public init(store: StoreOf<SignInEthereumReducer>) {
    self.store = store
  }

  public var body: some View {
    WithViewStore(store, observe: { $0 }) { _ in
      VStack(spacing: 20) {
        Text("Sign-In with\nEthereum")
          .multilineTextAlignment(.center)
          .font(.largeTitle)
          .bold()

        Text("We use the signature to verify you're the owner of this wallet.")
          .multilineTextAlignment(.center)
          .padding(.horizontal, 20)
          .foregroundColor(.secondary)

        HStack(spacing: 12) {
          Color.red
            .frame(width: 41, height: 41)
            .clipShape(Circle())
            .padding(.leading, 12)

          VStack(alignment: .leading, spacing: 0) {
            Text("tomokisun.eth")
              .bold()
            Text("MetaMask wallet")
              .foregroundColor(Color.blue)
              .font(.callout)
          }

          Spacer()
        }
        .frame(height: 62)
        .frame(maxWidth: .infinity)
        .background(Color(uiColor: .quaternarySystemFill))
        .cornerRadius(8)

        Spacer()

        SignInButton(
          store: store.scope(
            state: \.signInButton,
            action: SignInEthereumReducer.Action.signInButton
          )
        )

        Text("Signing is free and will not send a transaction. Learn more about Ethereum signature here.")
          .multilineTextAlignment(.center)
          .foregroundColor(.secondary)
          .font(.caption)
      }
      .padding(.horizontal, 20)
    }
  }
}

struct SignInEthereumViewPreviews: PreviewProvider {
  static var previews: some View {
    SignInEthereumView(
      store: .init(
        initialState: SignInEthereumReducer.State(),
        reducer: SignInEthereumReducer()
      )
    )
  }
}
