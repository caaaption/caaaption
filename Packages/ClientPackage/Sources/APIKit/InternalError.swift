import Foundation

public enum InternalError: Error {
  case unknown
  case service(Decodable)
}
