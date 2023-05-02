import ComposableArchitecture
import QuickNodeClient
import Foundation

public struct BalanceSettingReducer: ReducerProtocol {
  public init() {}

  public struct State: Equatable {
    @BindingState var address = ""
    public init() {}
  }

  public enum Action: Equatable, BindableAction {
    case addWidget
    case responseBalance(TaskResult<Decimal>)
    case binding(BindingAction<State>)
  }
  
  @Dependency(\.quickNodeClient) var quickNodeClient

  public var body: some ReducerProtocol<State, Action> {
    BindingReducer()
    Reduce { state, action in
      switch action {
      case .addWidget:
        return EffectTask.task { [address = state.address] in
          await .responseBalance(
            TaskResult {
              try await self.quickNodeClient.getBalance(address)
            }
          )
        }
        
      case let .responseBalance(.success(balance)):
        print(balance)
        return EffectTask.none
        
      case .responseBalance(.failure):
        return EffectTask.none
        
      case .binding:
        return EffectTask.none
      }
    }
  }
}
