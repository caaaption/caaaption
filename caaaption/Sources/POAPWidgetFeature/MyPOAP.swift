import ComposableArchitecture
import POAPClient
import SwiftUI

public struct MyPOAPReducer: ReducerProtocol {
  public init() {}

  public struct State: Equatable {
    @BindingState var address = ""
    var rows: IdentifiedArrayOf<POAPClient.Scan> = []
    var isActivityIndicatorVisible = false
    var address = ""
    var errorMessage = ""

    public init() {}
  }

  public enum Action: Equatable, BindableAction {
    case onTask
    case scanResponse(TaskResult<[POAPClient.Scan]>)
    case searchButtonTapped
    case binding(BindingAction<State>)
  }

  @Dependency(\.poapClient) var poapClient
  @Dependency(\.date.now) var now

  public var body: some ReducerProtocol<State, Action> {
    BindingReducer()
    Reduce { state, action in
      switch action {
      case .onTask:
        state.address = "0x4F724516242829DC5Bc6119f666b18102437De53"
        if state.address.prefix(2) != "0x" {
          return .none
        }
        return .task { [address = state.address] in
          await .scanResponse(
            TaskResult {
              try await self.poapClient.scan(address)
            }
          )
        }

      case let .scanResponse(.success(rows)):
        state.rows = IdentifiedArray(uniqueElements: rows)
        return .none

      case let .scanResponse(.failure(error)):
        print(error)
        return .none

      case .searchButtonTapped:
        state.isActivityIndicatorVisible = true
        return .none

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
          TextField("Address", text: viewStore.binding(\.$address))

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
          .disabled(viewStore.isActivityIndicatorVisible)
        } footer: {
          Text(viewStore.errorMessage)
            .foregroundColor(Color.red)
            .disabled(viewStore.errorMessage.isEmpty)
        }

        Section {
          LazyVGrid(
            columns: Array(repeating: GridItem(), count: 4),
            alignment: .center,
            spacing: 12
          ) {
            ForEach(viewStore.rows) { scan in
              AsyncImage(url: scan.event.imageUrl) { image in
                image
                  .resizable()
                  .aspectRatio(contentMode: .fill)
                  .clipShape(Circle())
              } placeholder: {
                ProgressView()
              }
            }
          }
        }
      }
      .navigationTitle("MyPOAP")
      .navigationBarTitleDisplayMode(.inline)
      .task { await viewStore.send(.onTask).finish() }
    }
  }
}

#if DEBUG
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
#endif
