import XCTest
@testable import APIKit

final class APIKitTests: XCTestCase {
  func testRequestURL() {
    struct TestRequest: Request {
      typealias Response = String
      typealias Error = String
      
      var baseURL: URL = URL(string: "https://caaaption.com")!
      var path: String = "/api/tests"
      var method: HTTPMethod = .get
    }
    let api = TestRequest()
    let urlRequest = api.urlRequest
    XCTAssertEqual(urlRequest.url, URL(string: "https://caaaption.com/api/tests"))
  }
  
  func testRequestQueryItem() {
    struct TestRequest: Request {
      typealias Response = String
      typealias Error = String
      
      var baseURL: URL = URL(string: "https://caaaption.com")!
      var path: String = "/api/tests"
      var method: HTTPMethod = .get
      var queryItems: [URLQueryItem] = [.init(name: "id", value: "1")]
    }
    let api = TestRequest()
    let urlRequest = api.urlRequest
    XCTAssertEqual(urlRequest.url, URL(string: "https://caaaption.com/api/tests?id=1"))
  }
}
