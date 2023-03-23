import Photos
import SwiftUI
import ColorHex
import SwiftUIHelpers
import PhotoLibraryClient
import ComposableArchitecture

public struct UploadReducer: ReducerProtocol {
  public init() {}
  public struct State: Equatable {
    public var caption = ""
    public var rows: IdentifiedArrayOf<AssetPhotoReducer.State> = []
    public init() {}
  }
  
  public enum Action: Equatable {
    case task
    case changedCaption(String)
    
    case row(id: AssetPhotoReducer.State.ID, action: AssetPhotoReducer.Action)
  }
  
  @Dependency(\.photoLibraryClient) var photoLibraryClient
  
  public var body: some ReducerProtocol<State, Action> {
    Reduce { state, action in
      switch action {
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
      ZStack {
        Color(0x6DF63D)
          .edgesIgnoringSafeArea(.all)
        
        ScrollView {
          VStack {
            Spacer().frame(height: 8)
            
            Color(uiColor: .systemGray6)
              .frame(width: 31, height: 4)
              .cornerRadius(2)
            
            Spacer().frame(height: 42)
            
            ScrollView(.horizontal) {
              LazyHStack {
                ForEachStore(store.scope(state: \.rows, action: UploadReducer.Action.row(id:action:))) { rowStore in
                  AssetPhotoView(store: rowStore)
                }
              }
            }
            .frame(height: 256)
            
            Spacer().frame(height: 32)
            
            TextField(
              "What did you buy?",
              text: viewStore.binding(
                get: \.caption,
                send: UploadReducer.Action.changedCaption
              )
            )
            .font(.title3)
            .bold()
            .multilineTextAlignment(.center)
          }
        }
        .frame(maxHeight: .infinity)
        .background()
        .cornerRadius(36, corners: [.topLeft, .topRight])
        .edgesIgnoringSafeArea(.bottom)
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
