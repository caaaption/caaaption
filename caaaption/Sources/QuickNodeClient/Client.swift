import Foundation

public struct QuickNodeClient {
  public var getBalance: @Sendable (String) async throws -> Decimal
}

extension QuickNodeClient {
  public struct QuickNodeResponse: Codable {
    public let result: String
  }
}
