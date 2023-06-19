import ComposableArchitecture
import Foundation

extension QuickNodeClient: DependencyKey {
  public static let liveValue = Self.live()

  static func live() -> Self {
    actor Session {
      let baseURL: URL

      init(baseURL: URL) {
        self.baseURL = baseURL
      }

      private func request(urlRequest: URLRequest) async throws -> (Data, URLResponse) {
        return try await URLSession.shared.data(for: urlRequest)
      }

      func getBalance(address: String) async throws -> Decimal {
        var urlRequest = URLRequest(url: baseURL, cachePolicy: .returnCacheDataElseLoad)
        urlRequest.httpMethod = "POST"
        urlRequest.allHTTPHeaderFields = [
          "Content-Type": "application/json",
        ]
        urlRequest.httpBody = """
        {
          "method": "eth_getBalance",
          "params": ["\(address)", "latest"],
          "id": 1,
          "jsonrpc": "2.0"
        }
        """.data(using: .utf8)!
        let (data, _) = try await request(urlRequest: urlRequest)
        let response = try decoder.decode(QuickNodeResponse.self, from: data)
        let value = Int(strtoul(response.result, nil, 16))
        return Converter.toEther(wei: value)
      }
    }

    let session = Session(baseURL: baseURL)

    return Self(
      getBalance: { try await session.getBalance(address: $0) }
    )
  }
}

enum Converter {
  static let etherInWei = pow(Decimal(10), 18)

  static func toEther(wei: Int) -> Decimal {
    guard let decimalWei = Decimal(string: wei.description) else {
      return 0.0
    }
    return decimalWei / etherInWei
  }
}

private let decoder = { () -> JSONDecoder in
  let decoder = JSONDecoder()
  return decoder
}()
