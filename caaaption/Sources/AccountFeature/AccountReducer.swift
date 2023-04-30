import ComposableArchitecture
import ServerConfig
import UIApplicationClient

public struct AccountReducer: ReducerProtocol {
  public init() {}

  public struct State: Equatable {
    public init() {}
  }

  public enum Action: Equatable {
    case privacyPolicy
  }

  @Dependency(\.applicationClient.open) var openURL

  public var body: some ReducerProtocol<State, Action> {
    Reduce { _, action in
      switch action {
      case .privacyPolicy:
        return .fireAndForget {
          _ = await self.openURL(
            ServerConfig.privacyPolicy,
            [:]
          )
        }
      }
    }
  }
}
