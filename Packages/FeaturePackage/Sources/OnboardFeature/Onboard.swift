import ComposableArchitecture
import SwiftUI

public struct OnboardReducer: ReducerProtocol {
  public init() {}

  public struct State: Equatable {
    var path = StackState<Path.State>()
    var welcome = WelcomeReducer.State()
    public init() {}
  }

  public enum Action: Equatable {
    case path(StackAction<Path.State, Path.Action>)
    case welcome(WelcomeReducer.Action)
  }

  public var body: some ReducerProtocol<State, Action> {
    Reduce { state, action in
      switch action {
      case .welcome(.getStartedButtonTapped):
        state.path.append(.connectWithWallet())
        return .none

      case .welcome:
        return .none

      case let .path(action):
        switch action {
        default:
          return .none
        }
      }
    }
    .forEach(\.path, action: /Action.path) {
      Path()
    }
  }

  public struct Path: ReducerProtocol {
    public enum State: Equatable {
      case connectWithWallet(ConnectWithWalletReducer.State = .init())
      case signInEthereum(SignInEthereumReducer.State = .init())
    }

    public enum Action: Equatable {
      case connectWithWallet(ConnectWithWalletReducer.Action)
      case signInEthereum(SignInEthereumReducer.Action)
    }

    public var body: some ReducerProtocol<State, Action> {
      Scope(state: /State.connectWithWallet, action: /Action.connectWithWallet) {
        ConnectWithWalletReducer()
      }
      Scope(state: /State.signInEthereum, action: /Action.signInEthereum) {
        SignInEthereumReducer()
      }
    }
  }
}

public struct OnboardView: View {
  let store: StoreOf<OnboardReducer>

  public init(store: StoreOf<OnboardReducer>) {
    self.store = store
  }

  public var body: some View {
    NavigationStackStore(
      store.scope(
        state: \.path,
        action: { .path($0) }
      )
    ) {
      WelcomeView(
        store: store.scope(
          state: \.welcome,
          action: OnboardReducer.Action.welcome
        )
      )
    } destination: {
      switch $0 {
      case .connectWithWallet:
        CaseLet(
          state: /OnboardReducer.Path.State.connectWithWallet,
          action: OnboardReducer.Path.Action.connectWithWallet,
          then: ConnectWithWalletView.init(store:)
        )
      case .signInEthereum:
        CaseLet(
          state: /OnboardReducer.Path.State.signInEthereum,
          action: OnboardReducer.Path.Action.signInEthereum,
          then: SignInEthereumView.init(store:)
        )
      }
    }
  }
}

struct OnboardViewPreviews: PreviewProvider {
  static var previews: some View {
    OnboardView(
      store: .init(
        initialState: OnboardReducer.State(),
        reducer: OnboardReducer()
      )
    )
  }
}
