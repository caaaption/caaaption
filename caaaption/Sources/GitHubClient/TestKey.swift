import Dependencies
import XCTestDynamicOverlay

extension DependencyValues {
  public var gitHubClient: GitHubClient {
    get { self[GitHubClient.self] }
    set { self[GitHubClient.self] = newValue }
  }
}

extension GitHubClient: TestDependencyKey {
  public static let testValue = Self(
    contributors: unimplemented("\(Self.self).contributors")
  )
}

extension GitHubClient {
  public static let noop = Self(
    contributors: { _, _ in try await Task.never() }
  )
}
