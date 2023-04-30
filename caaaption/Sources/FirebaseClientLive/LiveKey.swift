import Dependencies
import FirebaseClient

extension FirebaseClient: DependencyKey {
  public static let liveValue = Self(
    fetchGlobalsConfig: { try await Task.never() }
  )
}
