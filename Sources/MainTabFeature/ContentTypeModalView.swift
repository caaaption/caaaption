import SwiftUI
import ComposableArchitecture

public struct ContentTypeModalView: View {
  let store: StoreOf<ContentTypeModalReducer>

  public init(store: StoreOf<ContentTypeModalReducer>) {
    self.store = store
  }

  public var body: some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
      VStack(spacing: 12) {
        Button("📸 camera", action: { viewStore.send(.cameraTapped) })
          .frame(height: 48)
          .frame(maxWidth: .infinity)
          .background(Color.systemGray6)
          .cornerRadius(6)
        
        Button("🖼️ photo album", action: { viewStore.send(.photoLibraryTapped) })
          .frame(height: 48)
          .frame(maxWidth: .infinity)
          .background(Color.systemGray6)
          .cornerRadius(6)
        
        Button(action: { viewStore.send(.digitalCollectiveTapped) }) {
          VStack(alignment: .center, spacing: 8) {
            Text("⛓️ digital collectibles")
            
            Text("sometimes referred to as non-fungible tokens (NFTs), are unique digital items that use blockchain technology to provide a record of collectible ownership.")
              .foregroundColor(.systemGray2)
          }
          .padding(.vertical, 14)
          .padding(.horizontal, 24)
        }
        .frame(maxWidth: .infinity)
        .background(Color.systemGray6)
        .cornerRadius(6)
        .cornerRadius(6)
      }
      .padding(.horizontal, 24)
    }
  }
}

struct ContentTypeModalViewPreviews: PreviewProvider {
  static var previews: some View {
    ContentTypeModalView(
      store: .init(
        initialState: ContentTypeModalReducer.State(),
        reducer: ContentTypeModalReducer()
      )
    )
    .previewLayout(.sizeThatFits)
  }
}
