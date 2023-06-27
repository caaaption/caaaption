import Dependencies
import Foundation
import Kingfisher

extension KingfisherClient: DependencyKey {
  public static let liveValue = Self(
    clearMemoryCache: ImageCache.default.clearMemoryCache
  )
}
