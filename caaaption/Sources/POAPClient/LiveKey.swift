import ComposableArchitecture
import Foundation

extension POAPClient: DependencyKey {
  public static let liveValue = Self.live()
  
  static func live() -> Self {
    let session = Session()

    return Self(
      scan: { try await session.scan(address: $0) }
    )
  }
}

actor Session {
  let decoder: JSONDecoder = {
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    return decoder
  }()
  
  func scan(address: String) async throws -> [POAPClient.Scan] {
    let url = URL(string: "https://api.poap.tech/actions/scan/\(address)")!
    let (data, _) = try await URLSession.shared.data(from: url)
    return try decoder.decode([POAPClient.Scan].self, from: data)
  }
}
