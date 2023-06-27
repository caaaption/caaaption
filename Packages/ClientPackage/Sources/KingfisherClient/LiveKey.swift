import Kingfisher
import Dependencies
import Foundation

extension KingfisherClient: DependencyKey {
  public static let liveValue = Self(
    clearMemoryCache: ImageCache.default.clearMemoryCache
  )
}
