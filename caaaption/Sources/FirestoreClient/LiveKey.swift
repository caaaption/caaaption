import ComposableArchitecture

extension FirestoreClient: DependencyKey {
  public static let liveValue = Self()
}
