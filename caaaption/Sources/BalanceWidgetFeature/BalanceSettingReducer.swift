import BalanceWidget
import ComposableArchitecture
import Foundation
import QuickNodeClient
import UserDefaultsClient

public struct BalanceSettingReducer: ReducerProtocol {
  public init() {}

  public struct State: Equatable {
    @BindingState var address = ""
    var entry: BalanceWidget.Entry?

    public init() {}
  }

  public enum Action: Equatable, BindableAction {
    case task
    case addWidget
    case responseBalance(TaskResult<Decimal>)
    case binding(BindingAction<State>)
  }

  @Dependency(\.quickNodeClient) var quickNodeClient
  @Dependency(\.userDefaults) var userDefaults

  public var body: some ReducerProtocol<State, Action> {
    BindingReducer()
    Reduce { state, action in
      switch action {
      case .task:
        let input = try? userDefaults.codableForKey(BalanceWidget.Input.self, forKey: BalanceWidget.Constant.kind)
        state.address = input?.address ?? ""
        
        return EffectTask.task {
          .addWidget
        }

      case .addWidget:
        return EffectTask.task { [address = state.address] in
          let input = BalanceWidget.Input(address: address)
          await userDefaults.setCodable(input, forKey: BalanceWidget.Constant.kind)

          return await .responseBalance(
            TaskResult {
              try await self.quickNodeClient.getBalance(address)
            }
          )
        }

      case let .responseBalance(.success(balance)):
        state.entry = BalanceWidget.Entry(
          date: Date(),
          balance: balance
        )
        return EffectTask.none

      case .responseBalance(.failure):
        state.entry = nil
        return EffectTask.none

      case .binding:
        return EffectTask.none
      }
    }
  }
}
