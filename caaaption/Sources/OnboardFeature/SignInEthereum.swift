import ComposableArchitecture
import SwiftUI

public struct SignInEthereumReducer: ReducerProtocol {
  public init() {}

  public struct State: Equatable {
    public init() {}
  }

  public enum Action: Equatable {
    case task
  }

  public var body: some ReducerProtocol<State, Action> {
    Reduce { _, action in
      switch action {
      case .task:
        return EffectTask.none
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

        Text("Continue to Sign-In")
          .frame(height: 56)
          .frame(maxWidth: .infinity)
          .bold()
          .foregroundColor(Color.white)
          .background(Color.black)
          .clipShape(Capsule())

        Text("Signing is free and will not send a transaction. Learn more about Ethereum signature here.")
          .multilineTextAlignment(.center)
          .foregroundColor(.secondary)
          .font(.caption)
      }
      .padding(.horizontal, 20)
    }
  }
}

#if DEBUG
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
#endif