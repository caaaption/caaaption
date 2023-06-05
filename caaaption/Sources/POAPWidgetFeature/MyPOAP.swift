import ComposableArchitecture
import POAPClient
import SwiftUI

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
      ScrollView {
        LazyVGrid(
          columns: [GridItem(), GridItem()],
          alignment: .center,
          spacing: 12
        ) {
          ForEach(viewStore.rows) { scan in
            AsyncImage(
              url: URL(string: scan.event.imageUrl)
            ) { image in
              image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .clipShape(Circle())
            } placeholder: {
              ProgressView()
            }
          }
        }
        .padding(.horizontal, 12)
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
