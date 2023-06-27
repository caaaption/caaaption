import APIKit
import Foundation

public struct POAPClient {
  public var scan: @Sendable (ScanRequest) async throws -> ScanRequest.Response
}

public struct ScanRequest: Request {
  public typealias Response = [Scan]
  public typealias Error = String

  let address: String

  public init(address: String) {
    self.address = address
  }

  public var baseURL: URL {
    URL(string: "https://api.poap.tech")!
  }

  public var path: String {
    "/actions/scan/\(address)"
  }

  public var method: HTTPMethod = .get
  public var headerFields = ["X-API-Key": POAP_API_KEY]
}

public struct Scan: Codable, Equatable, Identifiable {
  public var id: String {
    return tokenId
  }

  public let tokenId: String
  public let owner: String
  public let chain: String
  public let created: String
  public let event: Event

  public struct Event: Codable, Equatable, Identifiable {
    public let id: Int
    public let fancyId: String
    public let name: String
    public let eventUrl: String
    public let imageUrl: URL
    public let description: String
  }
}
