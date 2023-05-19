public struct POAPClient {
  public var scan: @Sendable () async throws -> String
}

extension POAPClient {
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
      public let imageUrl: String
      public let description: String
    }
  }
}
