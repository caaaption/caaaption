import Dependencies
import XCTestDynamicOverlay

public extension DependencyValues {
  var kingfisherClient: KingfisherClient {
    get { self[KingfisherClient.self] }
    set { self[KingfisherClient.self] = newValue }
  }
}

extension KingfisherClient: TestDependencyKey {
  public static let previewValue = Self.noop
  public static let testValue = Self(
    clearMemoryCache: unimplemented("\(Self.self).clearMemoryCache")
  )
}

public extension KingfisherClient {
  static let noop = Self(
    clearMemoryCache: {}
  )
}
