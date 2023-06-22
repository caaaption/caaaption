import Foundation

public struct ServerConfig: Codable, Equatable {
  public let appId: String

  public init(
    appId: String = "6449177523"
  ) {
    self.appId = appId
  }
}

public extension ServerConfig {
  var appStoreURL: URL {
    URL(string: "https://apps.apple.com/us/app/caaaption/id\(appId)")!
  }

  var appStoreReviewUrl: URL {
    URL(string: "https://itunes.apple.com/us/app/apple-store/id\(appId)?mt=8&action=write-review")!
  }
}
