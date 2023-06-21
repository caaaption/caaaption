import Foundation

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
    if !queryItems.isEmpty {
      urlComponents.queryItems = queryItems
    }
    var request = URLRequest(url: urlComponents.url!, cachePolicy: .returnCacheDataElseLoad)
    request.allHTTPHeaderFields = headerFields
    request.httpMethod = method.rawValue
    request.httpBody = httpBody
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    return request
  }
}
