import UIKit
import Photos
import Dependencies
import PhotoLibraryClient

extension PhotoLibraryClient: DependencyKey {
  public static let liveValue = Self.live()
  
  public static func live() -> Self {
    func fetchAssets() -> [PHAsset] {
      let options = PHFetchOptions()
      options.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
      let result = PHAsset.fetchAssets(with: options)
      var assets = [PHAsset]()
      result.enumerateObjects { asset, _, _ in
        assets.append(asset)
      }
      return assets
    }
    actor Session {
      func requestImage(asset: PHAsset, targetSize: CGSize) async throws -> UIImage {
        typealias RequestedImageContinuation = CheckedContinuation<UIImage, Error>
        let phImageManager = PHImageManager.default()
        return try await withCheckedThrowingContinuation { (continuation: RequestedImageContinuation) in
          let options = PHImageRequestOptions()
          options.deliveryMode = .highQualityFormat
          phImageManager.requestImage(
            for: asset,
            targetSize: targetSize,
            contentMode: .aspectFill,
            options: options,
            resultHandler: { image, _ in
              guard let image = image else {
                continuation.resume(throwing: PhotoImageRequesterError.failedToFetchImage)
                return
              }
              continuation.resume(returning: image)
            }
          )
        }
      }
    }
    let session = Session()
    return Self(
      fetchAssets: { fetchAssets() },
      requestImage: { try await session.requestImage(asset: $0, targetSize: $1) }
    )
  }
}
