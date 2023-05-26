public struct AuthClient {
  public var nonce: @Sendable (_ address: String) async throws -> NonceResponse
  public var verify: @Sendable (_ param: VerifyParam) async throws -> VerifyResponse
}

public extension AuthClient {
  struct NonceResponse: Codable {
    public let nonce: String
  }
}

public extension AuthClient {
  struct VerifyParam {
    public let address: String
    public let message: String
    public let signature: String
  }
  struct VerifyResponse: Codable {
    public let customToken: String
  }
}
