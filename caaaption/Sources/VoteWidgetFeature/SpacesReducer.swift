import ComposableArchitecture
import SnapshotClient
import Dependencies

public struct SpacesReducer: ReducerProtocol {
  public init() {}

  public struct State: Equatable {
    public init() {}
  }

  public enum Action: Equatable {}
  
  @Dependency(\.snapshotClient) var snapshotClient

  public var body: some ReducerProtocol<State, Action> {
    Reduce { _, action in
      switch action {}
    }
  }
}
