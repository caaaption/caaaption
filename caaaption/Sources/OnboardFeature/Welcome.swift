import ComposableArchitecture
import SwiftUI
import ServerConfig

public struct WelcomeReducer: ReducerProtocol {
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

public struct WelcomeView: View {
  let store: StoreOf<WelcomeReducer>

  public init(store: StoreOf<WelcomeReducer>) {
    self.store = store
  }

  public var body: some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
      VStack(spacing: 24) {
        Spacer()
        Text("Welcome to\ncaaaption")
          .multilineTextAlignment(.center)
          .font(.largeTitle)
          .bold()
        
        NavigationLink {
          Text("Connect with wallet")
        } label: {
          Text("Get started")
            .frame(height: 56)
            .frame(maxWidth: .infinity)
            .bold()
            .foregroundColor(Color.white)
            .background(Color.black)
            .clipShape(Capsule())
        }
        
        Text("By continuing, you agree to caaaption [Terms & Conditions](\(ServerConfig.termsConditions)) and [Privacy Policy](\(ServerConfig.privacyPolicy)).")
          .multilineTextAlignment(.center)
          .foregroundColor(.secondary)
          .font(.caption)
          .padding(.horizontal, 20)
      }
      .padding(.horizontal, 20)
      .task { await viewStore.send(.task).finish() }
    }
  }
}

#if DEBUG
  struct WelcomeViewPreviews: PreviewProvider {
    static var previews: some View {
      WelcomeView(
        store: .init(
          initialState: WelcomeReducer.State(),
          reducer: WelcomeReducer()
        )
      )
    }
  }
#endif
