import Foundation
import ComposableArchitecture

extension GitHubClient: DependencyKey {
  public static let liveValue = Self.live()
  
  public static func live() -> Self {
    let session = GitHubClientSession()
    return Self(
      contributors: { try await session.contributors(owner: $0, repo: $1) }
    )
  }
}

actor GitHubClientSession {
  let decoder: JSONDecoder = {
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    return decoder
  }()

  func contributors(owner: String, repo: String) async throws -> [GitHubClient.Contributor] {
    let url = URL(string: "https://api.github.com/repos/\(owner)/\(repo)/contributors")!
    let (data, _) = try await URLSession.shared.data(from: url)
    return try decoder.decode([GitHubClient.Contributor].self, from: data)
  }
}
