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
    let actor = SnapshotClientActor(apolloClient: apolloClient)

    return Self(
      proposal: { try await actor.proposal(id: $0) },
      proposals: { try await actor.proposals(spaceName: $0) },
      spaces: { try await actor.spaces() }
    )
  }
}

actor SnapshotClientActor {
  let apolloClient: ApolloClient

  init(apolloClient: ApolloClient) {
    self.apolloClient = apolloClient
  }

  func proposal(
    id: String
  ) async throws -> SnapshotModel.ProposalQuery.Data {
    let query = SnapshotModel.ProposalQuery(id: id)
    return try await apolloClient.fetch(query: query)
  }
  
  func proposals(
    spaceName: String
  ) async throws -> SnapshotModel.ProposalsQuery.Data {
    let query = SnapshotModel.ProposalsQuery(spaceName: spaceName)
    return try await apolloClient.fetch(query: query)
  }
  
  func spaces() async throws -> SnapshotModel.SpacesQuery.Data {
    let query = SnapshotModel.SpacesQuery(idIn: [])
    return try await apolloClient.fetch(query: query)
  }
}
