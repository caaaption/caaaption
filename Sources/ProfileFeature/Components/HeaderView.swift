import ComposableArchitecture
import SwiftUI

public struct HeaderView: View {
  let store: StoreOf<HeaderReducer>

  public init(store: StoreOf<HeaderReducer>) {
    self.store = store
  }

  public var body: some View {
    WithViewStore(store, observe: { $0 }) { _ in
    }
  }
}

struct HeaderViewPreviews: PreviewProvider {
  static var previews: some View {
    HeaderView(
      store: .init(
        initialState: HeaderReducer.State(),
        reducer: HeaderReducer()
      )
    )
    .previewLayout(.sizeThatFits)
  }
}
