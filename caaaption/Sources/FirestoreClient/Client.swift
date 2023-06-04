import FirebaseFirestore

public struct FirestoreClient {
  public var listen: () async throws -> AsyncThrowingStream<DocumentSnapshot, Error>
}

public extension FirestoreClient {
  func listen<T: Codable>(
    documentPath: String,
    as: T.Type
  ) async throws -> AsyncThrowingStream<T, Error> {
    return AsyncThrowingStream { continuation in
      do {
        for try await result in try await self.listen() {
          do {
            let value = result.data(as: T.self)
            continuation.yield(with: .success(value))
          } catch {
            continuation.yield(with: .failure(error))
          }
        }
      } catch {
        continuation.yield(with: .failure(error))
      }
    }
  }
}
