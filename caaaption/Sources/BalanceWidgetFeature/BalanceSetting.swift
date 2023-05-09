import BalanceWidget
import ComposableArchitecture
import Foundation
import QuickNodeClient
import SwiftUI
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
    case dismiss
    case responseBalance(TaskResult<Decimal>)
    case binding(BindingAction<State>)
  }

  @Dependency(\.quickNodeClient) var quickNodeClient
  @Dependency(\.userDefaults) var userDefaults
  @Dependency(\.dismiss) var dismiss

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

      case .dismiss:
        return EffectTask.fireAndForget {
          await self.dismiss()
        }

      case let .responseBalance(.success(balance)):
        state.entry = BalanceWidget.Entry(
          date: Date(),
          address: state.address,
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

public struct BalanceSettingView: View {
  let store: StoreOf<BalanceSettingReducer>

  public init(store: StoreOf<BalanceSettingReducer>) {
    self.store = store
  }

  public var body: some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
      VStack(spacing: 12) {
        Spacer()

        if let entry = viewStore.entry {
          BalanceWidget.WidgetView(entry: entry)
        }

        Spacer()

        TextField(
          "Search addresses",
          text: viewStore.binding(\.$address)
        )

        Button(action: { viewStore.send(.addWidget) }) {
          HStack {
            Image(systemName: "plus.circle.fill")
              .tint(Color.white)
            Text("Add Widget")
              .bold()
              .foregroundColor(Color.white)
          }
          .frame(height: 50, alignment: .center)
          .frame(maxWidth: CGFloat.infinity)
          .background(Color.blue)
          .clipShape(Capsule())
        }
      }
      .task { await viewStore.send(.task).finish() }
      .padding(.horizontal, 12)
      .navigationTitle("Balance Widget")
      .navigationBarTitleDisplayMode(.inline)
      .toolbar {
        ToolbarItem(placement: .navigationBarTrailing) {
          Button {
            viewStore.send(.dismiss)
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

#if DEBUG
  import SwiftUIHelpers

  struct BalanceSettingViewPreviews: PreviewProvider {
    static var previews: some View {
      Preview {
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
  }
#endif
