import Dependencies
import Foundation
import ServerConfig

public extension ServerConfigClient {
  static func live(
    fetch: @escaping @Sendable () async throws -> ServerConfig
  ) -> Self {
    Self(
      config: {
        (UserDefaults.standard.object(forKey: serverConfigKey) as? Data)
          .flatMap { try? jsonDecoder.decode(ServerConfig.self, from: $0) }
          ?? ServerConfig()
      },
      refresh: {
        let config = try await fetch()
        if let data = try? jsonEncoder.encode(config) {
          UserDefaults.standard.set(data, forKey: serverConfigKey)
        }
        return config
      }
    )
  }
}

let jsonDecoder = JSONDecoder()
let jsonEncoder = JSONEncoder()

private let serverConfigKey = "com.caaaption.serverConfigKey"
