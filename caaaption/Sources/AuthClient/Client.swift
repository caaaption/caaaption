public struct AuthClient {
  var nonce: @Sendable (_ address: String) async throws -> String
  var verify: @Sendable (_ param: VerifyParam) async throws -> String
}

extension AuthClient {
  public func nonce(address: String) async throws -> String {
    return try await self.nonce(address)
  }
  
  public func verify(
    address: String,
    nonce: String,
    signature: String
  ) async throws -> String {
    return try await self.verify(
      VerifyParam(
        address: address,
        message: "",
        signature: signature
      )
    )
  }
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
