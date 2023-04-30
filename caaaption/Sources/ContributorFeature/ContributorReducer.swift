import ComposableArchitecture
import Foundation
import GitHubClient
import UIApplicationClient

public struct ContributorReducer: ReducerProtocol {
  public init() {}

  public struct State: Equatable {
    public var contributors: [GitHubClient.Contributor] = []

    public init() {}
  }

  public enum Action: Equatable {
    case task
    case refreshable
    case contributorsResponse(TaskResult<[GitHubClient.Contributor]>)
    case tappendContributor(Int)
  }

  @Dependency(\.githubClient.contributors) var contributors
  @Dependency(\.applicationClient.open) var openURL

  public var body: some ReducerProtocol<State, Action> {
    Reduce { state, action in
      switch action {
      case .task:
        return EffectTask.task {
          await .contributorsResponse(
            TaskResult {
              try await self.contributors("caaaption", "caaaption")
            }
          )
        }

      case .refreshable:
        return EffectTask.run { send in
          await send(.task)
        }

      case let .contributorsResponse(.success(contributors)):
        state.contributors = contributors
          .sorted(by: { $0.contributions > $1.contributions })
        return EffectTask.none

      case .contributorsResponse(.failure):
        state.contributors = []
        return EffectTask.none

      case let .tappendContributor(id):
        guard
          let contributor = state.contributors.first(where: { $0.id == id }),
          let url = URL(string: "https://github.com/\(contributor.login)")
        else {
          return EffectTask.none
        }
        return EffectTask.fireAndForget {
          _ = await self.openURL(url, [:])
        }
      }
    }
  }
}
