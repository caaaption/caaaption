import APIKit
import Dependencies
import Foundation

extension GitHubClient: DependencyKey {
  public static let liveValue = Self(
    contributors: { try await APIKit.shared.send($0) }
  )
}
