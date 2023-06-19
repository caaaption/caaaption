import Foundation

public struct GitHubClient {
  public var contributors: @Sendable (ContributorsRequest) async throws -> ContributorsRequest.Response
}

public struct ContributorsRequest: Sendable {
  public typealias Response = [Contributor]
  public var url: URL {
    return URL(string: "https://api.github.com/repos/\(owner)/\(repo)/contributors")!
  }

  let owner: String
  let repo: String

  public init(owner: String, repo: String) {
    self.owner = owner
    self.repo = repo
  }
}

public struct Contributor: Codable, Equatable, Identifiable {
  public let login: String
  public let id: Int
  public let avatarUrl: String
  public let contributions: Int
}
