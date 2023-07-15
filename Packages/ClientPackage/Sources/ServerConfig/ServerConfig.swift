import Foundation

public struct ServerConfig: Codable, Equatable {
  public let appId: String
  public let minimumSupportedAppVersion: String

  public init(
    appId: String = "6449177523",
    minimumSupportedAppVersion: String = "2023.6.16"
  ) {
    self.appId = appId
    self.minimumSupportedAppVersion = minimumSupportedAppVersion
  }
}

public extension ServerConfig {
  var appStoreURL: URL {
    URL(string: "https://apps.apple.com/us/app/caaaption/id\(appId)")!
  }

  var appStoreReviewURL: URL {
    URL(string: "https://itunes.apple.com/us/app/apple-store/id\(appId)?mt=8&action=write-review")!
  }

  var founderURL: URL {
    URL(string: "https://twitter.com/0xsatoya")!
  }

  var leadDevURL: URL {
    URL(string: "https://twitter.com/tomokisun")!
  }
}
