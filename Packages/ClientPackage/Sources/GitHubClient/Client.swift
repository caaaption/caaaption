import APIKit
import Foundation

public struct GitHubClient {
  public var contributors: @Sendable (ContributorsRequest) async throws -> ContributorsRequest.Response
}

public struct ContributorsRequest: Request {
  public typealias Response = [Contributor]
  public typealias Error = String

  let owner: String
  let repo: String

  public init(owner: String, repo: String) {
    self.owner = owner
    self.repo = repo
  }

  public var baseURL = URL(string: "https://api.github.com")!
  public var path: String {
    return "/repos/\(owner)/\(repo)/contributors"
  }

  public var method = HTTPMethod.get
}

public struct Contributor: Codable, Equatable, Identifiable {
  public let login: String
  public let id: Int
  public let avatarUrl: String
  public let contributions: Int
}
