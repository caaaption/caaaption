import Foundation

public struct ParameterEncoder {
  public init() {}
  public func encode<T: Encodable>(_ parameter: T) -> Data? {
    let encoder = JSONEncoder()
    encoder.keyEncodingStrategy = .convertToSnakeCase
    return try? encoder.encode(parameter)
  }
}
