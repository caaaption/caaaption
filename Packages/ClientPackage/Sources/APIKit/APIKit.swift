import Foundation

public class APIKit {
  let session = URLSession.shared
  public static let shared = APIKit()

  let decoder: JSONDecoder = {
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    return decoder
  }()

  public func send<T: Request>(_ api: T) async throws -> T.Response {
    let (data, response) = try await session.data(for: api.urlRequest)
    guard let httpURLResponse = response as? HTTPURLResponse else {
      throw InternalError.unknown
    }
    print("statusCode: \(httpURLResponse.statusCode)")
    guard 200 ..< 300 ~= httpURLResponse.statusCode else {
      let error = try decoder.decode(T.Error.self, from: data)
      throw InternalError.service(error)
    }
    return try decoder.decode(T.Response.self, from: data)
  }
}
