import Foundation

public struct UserDefaultsClient {
  public var boolForKey: @Sendable (String) -> Bool
  public var dataForKey: @Sendable (String) -> Data?
  public var doubleForKey: @Sendable (String) -> Double
  public var integerForKey: @Sendable (String) -> Int
  public var remove: @Sendable (String) async -> Void
  public var setBool: @Sendable (Bool, String) async -> Void
  public var setData: @Sendable (Data?, String) async -> Void
  public var setDouble: @Sendable (Double, String) async -> Void
  public var setInteger: @Sendable (Int, String) async -> Void

  public func codableForKey<T: Codable>(_ type: T.Type, forKey key: String) throws -> T? {
    guard let data = dataForKey(key) else { return nil }
    return try decoder.decode(T.self, from: data)
  }

  public func setCodable(_ value: Codable, forKey key: String) async {
    let data = try? encoder.encode(value)
    return await setData(data, key)
  }
}

private let decoder = JSONDecoder()
private let encoder = JSONEncoder()
