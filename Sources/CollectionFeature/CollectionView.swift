import ComposableArchitecture
import SwiftUI

public struct CollectionView: View {
  let store: StoreOf<CollectionReducer>
  let columns = [
    GridItem(.flexible(), spacing: 20),
    GridItem(.flexible(), spacing: 20),
  ]

  public init(store: StoreOf<CollectionReducer>) {
    self.store = store
  }

  public var body: some View {
    WithViewStore(store, observe: { $0 }) { _ in
      ScrollView {
        LazyVGrid(columns: columns, spacing: 20) {
          ForEach(0 ..< 100) { _ in
            Rectangle()
              .foregroundColor(.red)
              .background(Color.red)
              .aspectRatio(1, contentMode: .fit)
              .cornerRadius(22)
              .contextMenu {
                Button(action: {}) {
                  Label("Remove", systemImage: "trash")
                }
                Button(action: {}) {
                  Label("Edit Collection", systemImage: "apps.iphone")
                }
              }
          }
        }
        .padding(.horizontal, 20)
      }
      .navigationTitle("Digital Collectibles")
    }
  }
}

struct CollectionViewPreviews: PreviewProvider {
  static var previews: some View {
    CollectionView(
      store: .init(
        initialState: CollectionReducer.State(),
        reducer: CollectionReducer()
      )
    )
  }
}
