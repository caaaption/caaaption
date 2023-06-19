import AuthClient
import ComposableArchitecture
import SwiftUI

public struct SignInButtonReducer: ReducerProtocol {
  public init() {}

  public struct State: Equatable {
    var isActivityIndicatorVisible = false
    var nonce = ""
    public init() {}
  }

  public enum Action: Equatable {
    case signInButtonTapped

    case nonceResponse(TaskResult<String>)
    case customTokenResponse(TaskResult<String>)
  }

  @Dependency(\.authClient) var authClient

  public var body: some ReducerProtocol<State, Action> {
    Reduce { state, action in
      switch action {
      case .signInButtonTapped:
        state.isActivityIndicatorVisible = true
        return .task {
          await .nonceResponse(
            TaskResult {
              try await self.authClient.nonce(
                address: "0x4F724516242829DC5Bc6119f666b18102437De53"
              )
            }
          )
        }

      case let .nonceResponse(.success(nonce)):
        state.nonce = nonce
        state.isActivityIndicatorVisible = false
        return .none

      case let .nonceResponse(.failure(error)):
        print("error : \(error)")
        state.isActivityIndicatorVisible = false
        return .none

      case let .customTokenResponse(.success(customToken)):
        print("custom token : \(customToken)")
        state.isActivityIndicatorVisible = false
        return .none

      case let .customTokenResponse(.failure(error)):
        print("error : \(error)")
        state.isActivityIndicatorVisible = false
        return .none
      }
    }
  }
}

public struct SignInButton: View {
  let store: StoreOf<SignInButtonReducer>

  public init(store: StoreOf<SignInButtonReducer>) {
    self.store = store
  }

  public var body: some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
      Button {
        viewStore.send(.signInButtonTapped)
      } label: {
        if viewStore.isActivityIndicatorVisible {
          ProgressView()
        } else {
          Text("Continue to Sign-In")
        }
      }
      .frame(height: 56)
      .frame(maxWidth: .infinity)
      .bold()
      .foregroundColor(Color.white)
      .background(Color.black)
      .clipShape(Capsule())
    }
  }
}
