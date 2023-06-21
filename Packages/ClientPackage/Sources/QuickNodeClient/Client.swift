import APIKit
import Foundation

public struct QuickNodeClient {
  public var balance: @Sendable (BalanceRequest) async throws -> Decimal
}

public struct QuickNodeResponse: Codable {
  public let result: String
}

public struct BalanceRequest: Request {
  public typealias Response = QuickNodeResponse
  public typealias Error = String

  public let address: String
  public let httpBody: Data?

  public init(address: String) {
    self.address = address
    struct Parameter: Encodable {
      let method = "eth_getBalance"
      let id = 1
      let jsonrpc = "2.0"
      let params: [String]
    }
    let parameter = Parameter(params: [address, "latest"])
    httpBody = ParameterEncoder().encode(parameter)
  }

  public var baseURL = URL(string: "https://chaotic-quiet-meme.discover.quiknode.pro")!
  public var path = "/86804d1e5443408f5fe8f2c85d421bf018dbe433"
  public var method = HTTPMethod.post
}
