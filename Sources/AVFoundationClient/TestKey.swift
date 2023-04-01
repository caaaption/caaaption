import AVFoundation
import Dependencies
import XCTestDynamicOverlay

extension DependencyValues {
  public var avfoundationClient: AVFoundationClient {
    get { self[AVFoundationClient.self] }
    set { self[AVFoundationClient.self] = newValue }
  }
}

extension AVFoundationClient: TestDependencyKey {
  public static let previewValue = Self.noop
  
  public static let testValue = Self(
    authorizationStatus: XCTUnimplemented("\(Self.self).authorizationStatus"),
    requestAccess: XCTUnimplemented("\(Self.self).requestAccess")
  )
}

extension AVFoundationClient {
  public static let noop = Self(
    authorizationStatus: { _ in return .denied },
    requestAccess: { _ in try await Task.never() }
  )
}
