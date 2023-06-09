import ComposableArchitecture
import Kingfisher
import POAPClient
import POAPWidget
import SwiftUI
import UserDefaultsClient
import WidgetClient

public struct MyPOAPReducer: ReducerProtocol {
  public init() {}

  public struct State: Equatable {
    @BindingState var address = ""
    var rows: IdentifiedArrayOf<Scan> = []
    var isActivityIndicatorVisible = false
    var errorMessage: String?

    public init() {}
  }

  public enum Action: Equatable, BindableAction {
    case onTask
    case searchButtonTapped
    case requestMyPOAP
    case scanResponse(TaskResult<[Scan]>)
    case dismissButtonTapped
    case binding(BindingAction<State>)
  }

  @Dependency(\.poapClient) var poapClient
  @Dependency(\.date.now) var now
  @Dependency(\.userDefaults) var userDefaults
  @Dependency(\.dismiss) var dismiss
  @Dependency(\.widgetClient) var widgetClient

  public var body: some ReducerProtocol<State, Action> {
    BindingReducer()
    Reduce { state, action in
      switch action {
      case .onTask:
        let input = try? userDefaults.codableForKey(POAPWidget.Input.self, forKey: POAPWidget.Constant.kind)
        state.address = input?.address ?? ""
        if state.address.isEmpty {
          return .none
        }

        return .run { send in
          await send(.requestMyPOAP)
        }

      case .searchButtonTapped:
        return .run { send in
          await send(.requestMyPOAP)
        }

      case .requestMyPOAP:
        state.isActivityIndicatorVisible = true
        state.errorMessage = nil
        state.rows = []

        let request = ScanRequest(address: state.address)
        return .task {
          await .scanResponse(
            TaskResult {
              try await self.poapClient.scan(request)
            }
          )
        }

      case let .scanResponse(.success(rows)):
        state.isActivityIndicatorVisible = false
        state.rows = IdentifiedArray(
          uniqueElements: rows.prefix(50)
        )

        return .run { [address = state.address] _ in
          let input = POAPWidget.Input(address: address)
          await userDefaults.setCodable(input, forKey: POAPWidget.Constant.kind)
          widgetClient.reloadAllTimelines()
        }

      case let .scanResponse(.failure(error)):
        state.isActivityIndicatorVisible = false
        state.errorMessage = error.localizedDescription
        return .none

      case .dismissButtonTapped:
        return .run { _ in
          await self.dismiss()
        }

      case .binding:
        return .none
      }
    }
  }
}

public struct MyPOAPView: View {
  let store: StoreOf<MyPOAPReducer>

  public init(store: StoreOf<MyPOAPReducer>) {
    self.store = store
  }

  public var body: some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
      List {
        Section {
          TextField("ENS or Address", text: viewStore.binding(\.$address))

          Button {
            _ = UIApplication.shared.sendAction(
              #selector(UIResponder.resignFirstResponder),
              to: nil,
              from: nil,
              for: nil
            )
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
              .foregroundColor(Color.red)
          }
        }

        if !viewStore.rows.isEmpty {
          Section {
            LazyVGrid(
              columns: Array(repeating: GridItem(), count: 4),
              alignment: .center,
              spacing: 12
            ) {
              ForEach(viewStore.rows) { scan in
                KFImage(scan.event.imageUrl)
                  .placeholder { _ in
                    ProgressView()
                  }
                  .resizable()
                  .aspectRatio(contentMode: .fill)
                  .clipShape(Circle())
              }
            }
          }
        }
      }
      .navigationTitle("POAP")
      .navigationBarTitleDisplayMode(.inline)
      .task { await viewStore.send(.onTask).finish() }
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

struct MyPOAPViewPreviews: PreviewProvider {
  static var previews: some View {
    MyPOAPView(
      store: .init(
        initialState: MyPOAPReducer.State(),
        reducer: MyPOAPReducer()
      )
    )
  }
}
