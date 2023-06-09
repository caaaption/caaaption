import BalanceWidget
import ComposableArchitecture
import QuickNodeClient
import SwiftUI
import UserDefaultsClient
import WidgetClient

public struct BalanceSettingReducer: ReducerProtocol {
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
        let request = BalanceRequest(address: state.address)
        return .task {
          await .balanceResponse(
            TaskResult {
              try await self.quickNodeClient.balance(request)
            }
          )
        }

      case let .balanceResponse(.success(value)):
        state.balance = value
        state.errorMessage = nil
        state.isActivityIndicatorVisible = false

        return .run { [address = state.address] _ in
          let input = BalanceWidget.Input(address: address)
          await userDefaults.setCodable(input, forKey: BalanceWidget.Constant.kind)
          widgetClient.reloadAllTimelines()
        }

      case let .balanceResponse(.failure(error)):
        state.balance = nil
        state.isActivityIndicatorVisible = false
        state.errorMessage = error.localizedDescription
        return .none

      case .binding:
        return .none
      }
    }
  }
}

public struct BalanceSettingView: View {
  let store: StoreOf<BalanceSettingReducer>

  public init(store: StoreOf<BalanceSettingReducer>) {
    self.store = store
  }

  public var body: some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
      List {
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

        if let balance = viewStore.balance {
          Section("Balance") {
            Text("\(balance.description.prefix(6).lowercased()) ETH")
          }
        }
      }
      .task { await viewStore.send(.onTask).finish() }
      .navigationTitle("Balance")
      .navigationBarTitleDisplayMode(.inline)
      .toolbar {
        ToolbarItem(placement: .navigationBarTrailing) {
          Button {
            viewStore.send(.dismissButtonTapped)
          } label: {
            Image(systemName: "xmark.circle.fill")
              .symbolRenderingMode(.palette)
              .foregroundStyle(.gray, .bar)
              .font(.system(size: 30))
          }
        }
      }
    }
  }
}

struct BalanceSettingViewPreviews: PreviewProvider {
  static var previews: some View {
    NavigationStack {
      BalanceSettingView(
        store: .init(
          initialState: BalanceSettingReducer.State(),
          reducer: BalanceSettingReducer()
        )
      )
    }
  }
}
