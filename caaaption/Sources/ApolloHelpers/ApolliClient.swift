import Apollo
import ApolloAPI
import Foundation

public extension ApolloClient {
  struct AppGraphQLError: Error {
    public let applicationErrors: [Apollo.GraphQLError]
    
    internal init(_ errors: [Apollo.GraphQLError]) {
      self.applicationErrors = errors
    }
  }
}

public extension ApolloClient {
  @discardableResult func fetch<Query: GraphQLQuery>(query: Query) async throws -> Query.Data {
    try await withCheckedThrowingContinuation { continuation in
      self.fetch(query: query) { result in
        do {
          let response = try result.get()
          if let data = response.data {
            continuation.resume(returning: data)
          } else if let errors = response.errors {
            continuation.resume(with: .failure(AppGraphQLError(errors)))
          }
        } catch {
          continuation.resume(throwing: error)
        }
      }
    }
  }
}
