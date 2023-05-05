import Apollo
import ApolloAPI
import ApolloHelpers
import Dependencies
import Foundation
import SnapshotModel

extension SnapshotClient: DependencyKey {
  public static let liveValue = Self.live()

  public static func live() -> Self {
    let url = URL(string: "https://hub.snapshot.org/graphql")!
    let apolloClient = ApolloClient(url: url)
    return Self(
      proposal: { id in
        let query = SnapshotModel.ProposalQuery(id: id)
        return apolloClient.watch(query: query)
      },
      proposals: { spaceName in
        let query = SnapshotModel.ProposalsQuery(spaceName: spaceName)
        return apolloClient.watch(query: query)
      }
    )
  }
}
