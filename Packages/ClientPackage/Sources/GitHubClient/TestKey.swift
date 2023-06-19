import Dependencies
import XCTestDynamicOverlay

public extension DependencyValues {
  var githubClient: GitHubClient {
    get { self[GitHubClient.self] }
    set { self[GitHubClient.self] = newValue }
  }
}

extension GitHubClient: TestDependencyKey {
  public static let testValue = Self(
    contributors: unimplemented("\(Self.self).contributors")
  )
}

public extension GitHubClient {
  static let noop = Self(
    contributors: { _ in try await Task.never() }
  )
}
