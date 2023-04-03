import AVFoundation
import Dependencies
import XCTestDynamicOverlay

public extension DependencyValues {
  var avfoundationClient: AVFoundationClient {
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

public extension AVFoundationClient {
  static let noop = Self(
    authorizationStatus: { _ in .denied },
    requestAccess: { _ in try await Task.never() }
  )
}
