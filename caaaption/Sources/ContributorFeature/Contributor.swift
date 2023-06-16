import ComposableArchitecture
import Foundation
import GitHubClient
import PlaceholderAsyncImage
import SwiftUI

public struct ContributorReducer: ReducerProtocol {
  public init() {}

  public struct State: Equatable {
    public var contributors: [GitHubClient.Contributor] = []

    public init() {}
  }

  public enum Action: Equatable {
    case onTask
    case refreshable
    case contributorsResponse(TaskResult<[GitHubClient.Contributor]>)
    case tappendContributor(Int)
  }

  @Dependency(\.githubClient.contributors) var contributors
  @Dependency(\.openURL) var openURL

  public var body: some ReducerProtocol<State, Action> {
    Reduce { state, action in
      switch action {
      case .onTask:
        return EffectTask.task {
          await .contributorsResponse(
            TaskResult {
              try await self.contributors("caaaption", "caaaption")
            }
          )
        }

      case .refreshable:
        return EffectTask.run { send in
          await send(.onTask)
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
        return EffectTask.run { _ in
          await self.openURL(url)
        }
      }
    }
  }
}

public struct ContributorView: View {
  let store: StoreOf<ContributorReducer>

  public init(store: StoreOf<ContributorReducer>) {
    self.store = store
  }

  public var body: some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
      List(viewStore.contributors) { contributor in
        Button {
          viewStore.send(.tappendContributor(contributor.id))
        } label: {
          HStack(alignment: .center, spacing: 12) {
            PlaceholderAsyncImage(
              url: URL(string: contributor.avatarUrl)
            )
            .frame(width: 44, height: 44)
            .clipShape(Circle())

            Text(contributor.login)
              .bold()
          }
          .frame(height: 68)
        }
      }
      .navigationTitle("Contributors")
      .task { await viewStore.send(.onTask).finish() }
      .refreshable { await viewStore.send(.refreshable).finish() }
    }
  }
}

#if DEBUG
  import SwiftUIHelpers

  struct ContributorViewPreviews: PreviewProvider {
    static var previews: some View {
      ContributorView(
        store: .init(
          initialState: ContributorReducer.State(),
          reducer: ContributorReducer()
        )
      )
    }
  }
#endif
