import ComposableArchitecture
import SwiftUI
import WidgetClient
import UserDefaultsClient
import BalanceWidget
import QuickNodeClient

public struct BalanceReducer: ReducerProtocol {
  public init() {}

  public struct State: Equatable {
    @BindingState var address = ""
    var isActivityIndicatorVisible = false
    var errorMessage: String?
    var balance: Decimal?
    public init() {}
  }

  public enum Action: Equatable, BindableAction {
    case onTask
    case searchButtonTapped
    case dismissButtonTapped
    case balanceRequest
    case balanceResponse(TaskResult<Decimal>)
    case binding(BindingAction<State>)
  }
  
  @Dependency(\.dismiss) var dismiss
  @Dependency(\.userDefaults) var userDefaults
  @Dependency(\.widgetClient) var widgetClient
  @Dependency(\.quickNodeClient) var quickNodeClient

  public var body: some ReducerProtocol<State, Action> {
    BindingReducer()
    Reduce { state, action in
      switch action {
      case .onTask:
        let input = try? userDefaults.codableForKey(BalanceWidget.Input.self, forKey: BalanceWidget.Constant.kind)
        state.address = input?.address ?? ""
        
        if state.address.isEmpty {
          return .none
        }
        return .run { send in
          await send(.balanceRequest)
        }
        
      case .searchButtonTapped:
        return .run { send in
          await send(.balanceRequest)
        }
        
      case .dismissButtonTapped:
        return .run { _ in
          await self.dismiss()
        }
        
      case .balanceRequest:
        state.isActivityIndicatorVisible = true
        return .none
        
      case let .balanceResponse(.success(value)):
        state.balance = value
        state.isActivityIndicatorVisible = false

        return .run { [address = state.address] _ in
          let input = BalanceWidget.Input(address: address)
          await userDefaults.setCodable(input, forKey: BalanceWidget.Constant.kind)
          widgetClient.reloadAllTimelines()
        }
        
      case let .balanceResponse(.failure(error)):
        state.isActivityIndicatorVisible = false
        state.errorMessage = error.localizedDescription
        state.balance = nil
        return .none
        
      case .binding:
        return .none
      }
    }
  }
}

public struct BalanceView: View {
  let store: StoreOf<BalanceReducer>

  public init(store: StoreOf<BalanceReducer>) {
    self.store = store
  }

  public var body: some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
      Form {
        Section {
          TextField("Address", text: viewStore.binding(\.$address))
          
          Button {
            viewStore.send(.searchButtonTapped)
          } label: {
            HStack {
              Text("Search")
                .frame(maxWidth: .infinity, alignment: .leading)
              if viewStore.isActivityIndicatorVisible {
                ProgressView()
              }
            }
          }
          .disabled(
            viewStore.isActivityIndicatorVisible || viewStore.address.isEmpty
          )
        } footer: {
          if let message = viewStore.errorMessage {
            Text(message)
              .foregroundColor(.red)
          }
        }
        
        Section {
          Text("Address")
            .layoutPriority(1)
            .badge(viewStore.address)
          
          if let balance = viewStore.balance {
            Text("Balance")
              .badge("\(balance.description) ETH")
          } else {
            Text("Balance")
          }
        }
      }
      .navigationTitle("Balance")
      .navigationBarTitleDisplayMode(.inline)
      .task { await viewStore.send(.onTask).finish() }
    }
  }
}

#if DEBUG
  struct BalanceViewPreviews: PreviewProvider {
    static var previews: some View {
      NavigationStack {
        BalanceView(
          store: .init(
            initialState: BalanceReducer.State(),
            reducer: BalanceReducer()
          )
        )
      }
    }
  }
#endif
