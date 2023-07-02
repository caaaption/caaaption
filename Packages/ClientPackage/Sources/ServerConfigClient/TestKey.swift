import Dependencies
import ServerConfig
import XCTestDynamicOverlay

public extension DependencyValues {
  var serverConfig: ServerConfigClient {
    get { self[ServerConfigClient.self] }
    set { self[ServerConfigClient.self] = newValue }
  }
}

extension ServerConfigClient: TestDependencyKey {
  public static let previewValue = Self.noop

  public static let testValue = Self(
    config: unimplemented("\(Self.self).config", placeholder: ServerConfig()),
    refresh: unimplemented("\(Self.self).refresh")
  )
}

public extension ServerConfigClient {
  static let noop = Self(
    config: { .init() },
    refresh: { try await Task.never() }
  )
}
