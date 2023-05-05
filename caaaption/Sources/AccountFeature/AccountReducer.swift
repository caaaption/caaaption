import ComposableArchitecture
import ContributorFeature
import ServerConfig
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
