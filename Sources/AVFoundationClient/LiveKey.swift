import AVFoundation
import Dependencies

extension AVFoundationClient: DependencyKey {
  public static let liveValue = Self(
    authorizationStatus: { AVCaptureDevice.authorizationStatus(for: $0) },
    requestAccess: { await AVCaptureDevice.requestAccess(for: $0) }
  )
}
