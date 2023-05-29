import ComposableArchitecture
import SwiftUI
import POAPClient

public struct MyPOAPReducer: ReducerProtocol {
  public init() {}

  public struct State: Equatable {
    public var rows: IdentifiedArrayOf<POAPClient.Scan> = []
    public init() {}
  }

  public enum Action: Equatable {
    case task
    case scanResponse(TaskResult<[POAPClient.Scan]>)
  }
  
  @Dependency(\.poapClient) var poapClient

  public var body: some ReducerProtocol<State, Action> {
    Reduce { state, action in
      switch action {
      case .task:
        let address = "0x4F724516242829DC5Bc6119f666b18102437De53"
        return EffectTask.task {
          await .scanResponse(
            TaskResult {
              try await self.poapClient.scan(address)
            }
          )
        }
        
      case let .scanResponse(.success(rows)):
        state.rows = IdentifiedArray(uniqueElements: rows)
        return EffectTask.none

      case let .scanResponse(.failure(error)):
        print(error)
        return EffectTask.none
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
        ForEach(viewStore.rows) { scan in
          LazyVGrid(
            columns: [GridItem(), GridItem()],
            alignment: .center,
            spacing: 12
          ) {
            AsyncImage(url: URL(string: scan.event.imageUrl))
              .aspectRatio(contentMode: .fill)
              .clipped()
          }
        }
      }
      .navigationTitle("MyPOAP")
      .navigationBarTitleDisplayMode(.inline)
      .task { await viewStore.send(.task).finish() }
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
