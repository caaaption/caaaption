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

  func nonce(address: String) async throws -> String {
    let url = URL(string: "https://asia-northeast1-caaaption-staging.cloudfunctions.net/api/nonce")!
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.httpBody = """
    {
      "address": "\(address)"
    }
    """.data(using: .utf8)
    let (data, _) = try await URLSession.shared.data(for: request)
    let response = try decoder.decode(AuthClient.NonceResponse.self, from: data)
    return response.nonce
  }

  func verify(param: AuthClient.VerifyParam) async throws -> String {
    let url = URL(string: "https://asia-northeast1-caaaption-staging.cloudfunctions.net/api/verify")!
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.httpBody = """
    {
      "address": "\(param.address)",
      "message": "\(param.message)",
      "signature": "\(param.signature)"
    }
    """.data(using: .utf8)
    let (data, _) = try await URLSession.shared.data(for: request)
    let response = try decoder.decode(AuthClient.VerifyResponse.self, from: data)
    return response.customToken
  }
}
