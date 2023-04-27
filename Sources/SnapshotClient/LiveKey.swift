import Dependencies
import Apollo
import ApolloAPI
import SnapshotGraphQLModel
import Foundation

extension SnapshotClient: DependencyKey {
  public static let liveValue = Self.live()
  
  public static func live() -> Self {
    
    let url = URL(string: "https://hub.snapshot.org/graphql")!
    let apolloClient = ApolloClient(url: url)
    let actor = SnapshotClientActor(apolloClient: apolloClient)
    
    return Self(
      proposal: { try await actor.proposal(id: $0) }
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
  ) async throws -> GraphQLResult<SnapshotGraphQLModel.ProposalQuery.Data> {
    let query = SnapshotGraphQLModel.ProposalQuery(id: id)
    return try await apolloClient.fetch(query: query)
  }
}
