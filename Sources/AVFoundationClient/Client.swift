import AVFoundation
import ComposableArchitecture

public struct AVFoundationClient {
  public let authorizationStatus: @Sendable (AVMediaType) -> AVAuthorizationStatus
  public let requestAccess: @Sendable (AVMediaType) async throws -> Bool
}
