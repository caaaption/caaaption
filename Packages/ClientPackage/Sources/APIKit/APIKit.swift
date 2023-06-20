import Foundation

public enum HTTPMethod: String {
  case get = "GET"
  case post = "POST"
}

public enum InternalError: Error {
  case unknown
  case service(Decodable)
}

public protocol Request {
  var baseURL: URL { get }
  var path: String { get }
  var method: HTTPMethod { get }
  var queryItems: [URLQueryItem] { get }
  var httpBody: Data? { get }
  var headerFields: [String: String] { get }
  associatedtype Response: Decodable
  associatedtype Error: Decodable
}

public extension Request {
  var queryItems: [URLQueryItem] { [] }
  var httpBody: Data? { nil }
  var headerFields: [String: String] { [:] }
}

extension Request {
  var urlRequest: URLRequest {
    let url = baseURL.appendingPathComponent(path)
    var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)!
    urlComponents.queryItems = queryItems
    var request = URLRequest(url: urlComponents.url!)
    request.allHTTPHeaderFields = self.headerFields
    request.httpMethod = method.rawValue
    request.httpBody = httpBody
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    return request
  }
}

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
    guard 200..<300 ~= httpURLResponse.statusCode else {
      let error = try decoder.decode(T.Error.self, from: data)
      throw InternalError.service(error)
    }
    return try decoder.decode(T.Response.self, from: data)
  }
}
