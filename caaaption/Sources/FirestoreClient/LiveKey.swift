import ComposableArchitecture
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

extension FirestoreClient: DependencyKey {
  public static let liveValue: Self = {
    actor Session {
      func listen() async throws -> AsyncThrowingStream<DocumentSnapshot, Error> {
        return AsyncThrowingStream { continuation in
          let listener = Firestore.firestore().collection("config").document("globals")
            .addSnapshotListener { documentSnapshot, error in
              if let error {
                continuation.yield(with: .failure(error))
              }
              if let documentSnapshot {
                continuation.yield(with: .success(documentSnapshot))
              }
            }
          continuation.onTermination = { @Sendable _ in
            listener.remove()
          }
        }
      }
    }
    let session = Session()
    return Self(
      listen: { try await session.listen() }
    )
  }()
}
