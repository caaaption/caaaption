import APIKit
import Foundation

public struct QuickNodeResponse: Codable {
  public let result: String
}

public struct BalanceRequest: Request {
  public typealias Response = QuickNodeResponse
  public typealias Error = String
  
  public let address: String

  public init(address: String) {
    self.address = address
  }
  
  public var baseURL = URL(string: "https://chaotic-quiet-meme.discover.quiknode.pro")!
  public var path = "/86804d1e5443408f5fe8f2c85d421bf018dbe433"
  public var method = HTTPMethod.post
  public var httpBody: Data? {
    return """
    {
      "method": "eth_getBalance",
      "params": ["\(address)", "latest"],
      "id": 1,
      "jsonrpc": "2.0"
    }
    """.data(using: .utf8)
  }
}

public struct QuickNodeClient {
  public var balance: @Sendable (BalanceRequest) async throws -> Decimal
}
