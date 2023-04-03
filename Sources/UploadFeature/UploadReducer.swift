import ColorHex
import ComposableArchitecture
import PhotoLibraryClient
import Photos
import SwiftUI
import SwiftUIHelpers

public struct UploadReducer: ReducerProtocol {
  public init() {}
  public struct State: Equatable {
    @BindingState public var caption = ""
    public var rows: IdentifiedArrayOf<AssetPhotoReducer.State> = []
    public init() {}
  }

  public enum Action: BindableAction, Equatable {
    case binding(BindingAction<State>)
    case task
    case changedCaption(String)

    case row(id: AssetPhotoReducer.State.ID, action: AssetPhotoReducer.Action)
  }

  @Dependency(\.photoLibraryClient) var photoLibraryClient

  public var body: some ReducerProtocol<State, Action> {
    BindingReducer()
    Reduce { state, action in
      switch action {
      case .binding:
        return EffectTask.none

      case .task:
        let assets = photoLibraryClient.fetchAssets()
        state.rows = IdentifiedArray(
          uniqueElements: assets.map { AssetPhotoReducer.State(asset: $0) }
        )
        return EffectTask.none

      case let .changedCaption(caption):
        state.caption = caption
        return EffectTask.none

      case .row:
        return EffectTask.none
      }
    }
    .forEach(\.rows, action: /Action.row) {
      AssetPhotoReducer()
    }
  }
}

public struct UploadView: View {
  let store: StoreOf<UploadReducer>

  public init(store: StoreOf<UploadReducer>) {
    self.store = store
  }

  public var body: some View {
    WithViewStore(store) { viewStore in
      ScrollView {
        VStack {
          Spacer().frame(height: 42)

          ScrollView(.horizontal) {
            LazyHStack(spacing: 56) {
              ForEachStore(store.scope(state: \.rows, action: UploadReducer.Action.row(id:action:))) { rowStore in
                AssetPhotoView(store: rowStore)
              }
            }
          }
          .frame(height: 256)

          Spacer().frame(height: 32)

          TextField(
            "What did you buy?",
            text: viewStore.binding(\.$caption)
          )
          .font(.title3)
          .bold()
          .multilineTextAlignment(.center)
        }
      }
      .task { await viewStore.send(.task).finish() }
    }
  }
}

struct UploadViewPreview: PreviewProvider {
  static var previews: some View {
    UploadView(
      store: .init(
        initialState: UploadReducer.State(),
        reducer: UploadReducer()
      )
    )
  }
}
