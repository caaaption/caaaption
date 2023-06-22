import Foundation

public struct ServerConfig: Codable, Equatable {
  public let appId: String
  
  public init(
    appId: String = "6449177523"
  ) {
    self.appId = appId
  }
}

extension ServerConfig {
  public var appStoreURL: URL {
    URL(string: "https://apps.apple.com/us/app/caaaption/id\(appId)")!
  }
  
  public var appStoreReviewUrl: URL {
    URL(string: "https://itunes.apple.com/us/app/apple-store/id\(self.appId)?mt=8&action=write-review")!
  }
}
