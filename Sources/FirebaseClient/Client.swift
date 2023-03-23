import ComposableArchitecture

public struct FirebaseClient {
  public var fetchGlobalsConfig: @Sendable () async throws -> Void
  
  public init(
    fetchGlobalsConfig: @escaping @Sendable () async throws -> Void
  ) {
    self.fetchGlobalsConfig = fetchGlobalsConfig
  }
}
