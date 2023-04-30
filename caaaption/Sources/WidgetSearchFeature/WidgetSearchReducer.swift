import ComposableArchitecture

public struct WidgetSearchReducer: ReducerProtocol {
  public init() {}

  public struct State: Equatable {
    @BindingState public var searchable = ""
    public init() {}
  }

  public enum Action: Equatable, BindableAction {
    case task
    case refreshable
    case binding(BindingAction<State>)
  }
  
  @Dependency(\.mainQueue) var mainQueue
  private enum WidgetRequestID {}

  public var body: some ReducerProtocol<State, Action> {
    BindingReducer()
    Reduce { state, action in
      switch action {
      case .task:
        return EffectTask.none
        
      case .refreshable:
        return EffectTask.task {
          try await self.mainQueue.sleep(for: .seconds(2))
          return Action.task
        }
        .animation()
        .cancellable(id: WidgetRequestID.self)
        
      case .binding:
        return EffectTask.none
      }
    }
  }
  
//  public struct Destinations: ReducerProtocol {
//    public enum State: Equatable {
//      public enum Tag: Int {
//        case settings
//
//        var tag: Tag {
//          return self
//        }
//      }
//    }
//
//    public enum Action: Equatable {
//    }
//
//    public var body: some ReducerProtocol<State, Action> {
//      return EffectTask.none
//    }
//  }
}
