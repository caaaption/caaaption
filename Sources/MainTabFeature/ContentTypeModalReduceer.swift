import ComposableArchitecture

public struct ContentTypeModalReducer: ReducerProtocol {
  public init() {}

  public struct State: Equatable {
    public init() {}
  }

  public enum Action: Equatable {
    case cameraTapped
    case photoLibraryTapped
    case digitalCollectiveTapped
  }

  public var body: some ReducerProtocol<State, Action> {
    Reduce { _, action in
      switch action {
      case .cameraTapped:
        return EffectTask.none
        
      case .photoLibraryTapped:
        return EffectTask.none
        
      case .digitalCollectiveTapped:
        return EffectTask.none
      }
    }
  }
}
