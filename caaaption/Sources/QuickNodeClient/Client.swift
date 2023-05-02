import Foundation

public struct QuickNodeClient {
  public var getBalance: @Sendable (String) async throws -> Decimal
}

public extension QuickNodeClient {
  struct QuickNodeResponse: Codable {
    public let result: String
  }
}
