import ComposableArchitecture
import PhotoLibraryClient
import Photos
import SwiftUI

public struct AssetPhotoReducer: ReducerProtocol {
  public struct State: Equatable, Identifiable {
    public var id: String {
      asset.localIdentifier
    }

    var asset: PHAsset
    var image: UIImage?

    init(asset: PHAsset) {
      self.asset = asset
    }
  }

  public enum Action: Equatable {
    case onAppear
    case imageResponse(TaskResult<UIImage>)
  }

  @Dependency(\.photoLibraryClient) var photoLibraryClient

  public func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
    switch action {
    case .onAppear:
      return EffectTask.task { [asset = state.asset] in
        await .imageResponse(
          TaskResult {
            try await self.photoLibraryClient.requestImage(asset, CGSize(width: 200, height: 256))
          }
        )
      }
    case let .imageResponse(.success(image)):
      state.image = image
      return EffectTask.none
    case .imageResponse(.failure):
      return EffectTask.none
    }
  }
}

struct AssetPhotoView: View {
  let store: StoreOf<AssetPhotoReducer>

  struct ViewState: Equatable {
    let image: UIImage?
    init(state: AssetPhotoReducer.State) {
      image = state.image
    }
  }

  init(store: StoreOf<AssetPhotoReducer>) {
    self.store = store
  }

  var body: some View {
    WithViewStore(self.store.scope(state: ViewState.init)) { viewStore in
      if let image = viewStore.image {
        Image(uiImage: image)
          .frame(width: 200, height: 256)
          .cornerRadius(22)
      } else {
        ProgressView()
          .onAppear {
            Task {
              await viewStore.send(.onAppear).finish()
            }
          }
      }
    }
  }
}
