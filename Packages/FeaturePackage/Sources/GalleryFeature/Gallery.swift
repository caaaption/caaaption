import ComposableArchitecture
import SwiftUI

public struct GalleryReducer: ReducerProtocol {
  public init() {}

  public struct State: Equatable {
    public init() {}
  }

  public enum Action: Equatable {
    case onTask
  }

  public var body: some ReducerProtocol<State, Action> {
    Reduce { _, action in
      switch action {
      case .onTask:
        return .none
      }
    }
  }
}

public struct GalleryView: View {
  let store: StoreOf<GalleryReducer>

  public init(store: StoreOf<GalleryReducer>) {
    self.store = store
  }

  public var body: some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
      ScrollView(.vertical, showsIndicators: true) {
        LazyVStack(spacing: 16) {
          GallerySection(
            title: "Get Stuff Done",
            description: "Shortcuts to help you focus",
            action: {}
          ) {
            ForEach(0 ..< 10, id: \.self) { _ in
              Color.blue
                .frame(width: 170, height: 170)
                .cornerRadius(12)
            }
          }

          Divider()

          GallerySection(
            title: "Quick Shortcuts",
            description: "Less taps, more done with these fast shortcuts!",
            action: {}
          ) {
            ForEach(0 ..< 10, id: \.self) { _ in
              Color.red
                .frame(width: 170, height: 170)
                .cornerRadius(12)
            }
          }

          Divider()

          GallerySection(
            title: "Use Your Clipboard",
            description: "Copy and paste the day away.",
            action: {}
          ) {
            ForEach(0 ..< 10, id: \.self) { _ in
              Color.gray
                .frame(width: 170, height: 170)
                .cornerRadius(12)
            }
          }
        }
      }
      .navigationTitle("Gallery")
      .task { await viewStore.send(.onTask).finish() }
    }
  }
}

#if DEBUG
  struct GalleryViewPreviews: PreviewProvider {
    static var previews: some View {
      NavigationStack {
        GalleryView(
          store: .init(
            initialState: GalleryReducer.State(),
            reducer: GalleryReducer()
          )
        )
      }
    }
  }
#endif
