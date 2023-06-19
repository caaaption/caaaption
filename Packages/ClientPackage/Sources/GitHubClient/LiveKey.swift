import ComposableArchitecture
import Dependencies
import Foundation

extension GitHubClient: DependencyKey {
  public static let liveValue = Self.live()

  public static func live() -> Self {
    return Self(
      contributors: { request in
        let (data, _) = try await URLSession.shared.data(from: request.url)
        return try jsonDecoder.decode(ContributorsRequest.Response.self, from: data)
      }
    )
  }
}

let jsonDecoder: JSONDecoder = {
  let decoder = JSONDecoder()
  decoder.keyDecodingStrategy = .convertFromSnakeCase
  return decoder
}()
