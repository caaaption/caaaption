import ComposableArchitecture
import Foundation
import GitHubClient
import PlaceholderAsyncImage
import SwiftUI

public struct ContributorReducer: ReducerProtocol {
  public init() {}

  public struct State: Equatable {
    public var contributors: [Contributor] = []

    public init() {}
  }

  public enum Action: Equatable {
    case onTask
    case refreshable
    case contributorsResponse(TaskResult<[Contributor]>)
    case tappendContributor(Int)
    case doneButtonTapped
  }

  @Dependency(\.githubClient.contributors) var contributors
  @Dependency(\.openURL) var openURL
  @Dependency(\.dismiss) var dismiss

  public var body: some ReducerProtocol<State, Action> {
    Reduce { state, action in
      switch action {
      case .onTask:
        let request = ContributorsRequest(owner: "caaaption", repo: "caaaption")
        return .task {
          await .contributorsResponse(
            TaskResult {
              try await self.contributors(request)
            }
          )
        }

      case .refreshable:
        return .run { send in
          await send(.onTask)
        }

      case let .contributorsResponse(.success(contributors)):
        state.contributors = contributors
          .sorted(by: { $0.contributions > $1.contributions })
        return .none

      case .contributorsResponse(.failure):
        state.contributors = []
        return .none

      case let .tappendContributor(id):
        guard
          let contributor = state.contributors.first(where: { $0.id == id }),
          let url = URL(string: "https://github.com/\(contributor.login)")
        else {
          return .none
        }
        return .run { _ in
          await self.openURL(url)
        }
      case .doneButtonTapped:
        return .run { _ in
          await self.dismiss()
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
      NavigationStack {
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
        .navigationBarTitleDisplayMode(.inline)
        .task { await viewStore.send(.onTask).finish() }
        .refreshable { await viewStore.send(.refreshable).finish() }
        .toolbar {
          ToolbarItem(placement: .navigationBarTrailing) {
            Button("Done") {
              viewStore.send(.doneButtonTapped)
            }
            .bold()
          }
        }
      }
    }
  }
}

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
