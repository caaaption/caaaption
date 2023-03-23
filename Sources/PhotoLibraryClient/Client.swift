import UIKit
import Photos

public enum PhotoImageRequesterError: Error {
  case failedToFetchImage
}

public struct PhotoLibraryClient {
  public var fetchAssets: () -> [PHAsset]
  public var requestImage: @Sendable (PHAsset, CGSize) async throws -> UIImage
  
  public init(
    fetchAssets: @escaping () -> [PHAsset],
    requestImage: @escaping @Sendable (PHAsset, CGSize) async throws -> UIImage
  ) {
    self.fetchAssets = fetchAssets
    self.requestImage = requestImage
  }
}
