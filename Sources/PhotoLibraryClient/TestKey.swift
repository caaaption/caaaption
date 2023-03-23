import Photos
import Dependencies
import XCTestDynamicOverlay

extension DependencyValues {
  public var photoLibraryClient: PhotoLibraryClient {
    get { self[PhotoLibraryClient.self] }
    set { self[PhotoLibraryClient.self] = newValue }
  }
}

extension PhotoLibraryClient: TestDependencyKey {
  public static let previewValue = Self.noop
  
  public static let testValue = Self(
    fetchAssets: XCTUnimplemented("\(Self.self).fetchAssets"),
    requestImage: XCTUnimplemented("\(Self.self).requestImage")
  )
}

extension PhotoLibraryClient {
  public static let noop = Self(
    fetchAssets: { [] },
    requestImage: { _, _ in try await Task.never() }
  )
}
