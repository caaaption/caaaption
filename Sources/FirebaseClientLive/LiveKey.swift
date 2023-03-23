import FirebaseClient
import Dependencies

extension FirebaseClient: DependencyKey {
  public static let liveValue = Self(
    fetchGlobalsConfig: { try await Task.never() }
  )
}
