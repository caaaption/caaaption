import ComposableArchitecture
import Foundation

extension AuthClient: DependencyKey {
  public static let liveValue = Self.live()
  
  static func live() -> Self {
    let session = Session()
    
    return Self(
      nonce: { try await session.nonce(address: $0) },
      verify: { try await session.verify(param: $0) }
    )
  }
}

actor Session {
  let decoder: JSONDecoder = {
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    return decoder
  }()
  
  func nonce(address: String) async throws -> AuthClient.NonceResponse {
    let url = URL(string: "https://auth-api.caaaption-staging.com/api/nonce")!
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.httpBody = Data("""
    {
      "address": "\(address)"
    }
    """.utf8)
    let (data, _) = try await URLSession.shared.data(for: request)
    return try decoder.decode(AuthClient.NonceResponse.self, from: data)
  }
  
  func verify(param: AuthClient.VerifyParam) async throws -> AuthClient.VerifyResponse {
    let url = URL(string: "https://auth-api.caaaption-staging.com/api/verify")!
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.httpBody = Data("""
    {
      "address": "\(param.address)",
      "message": "\(param.message)",
      "signature": "\(param.signature)"
    }
    """.utf8)
    let (data, _) = try await URLSession.shared.data(for: request)
    return try decoder.decode(AuthClient.VerifyResponse.self, from: data)
  }
}
