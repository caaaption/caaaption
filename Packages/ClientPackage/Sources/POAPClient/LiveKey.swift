import APIKit
import Dependencies
import Foundation

extension POAPClient: DependencyKey {
  public static let liveValue = Self(
    scan: { try await APIKit.shared.send($0) }
  )
}
