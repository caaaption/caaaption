import ComposableArchitecture
import SwiftUI

public struct LinkReducer: ReducerProtocol {
  public init() {}

  public struct State: Equatable {
    public init() {}
  }

  public enum Action: Equatable {
    case doneButtonTapped
  }
  
  @Dependency(\.dismiss) var dismiss

  public func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
    switch action {
    case .doneButtonTapped:
      return .run { _ in
        await self.dismiss()
      }
    }
  }
}

public struct LinkView: View {
  let store: StoreOf<LinkReducer>

  public init(store: StoreOf<LinkReducer>) {
    self.store = store
  }

  public var body: some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
      List {
        Link("caaaption.com", destination: URL(string: "https://caaaption.com")!)
        Link("Twitter", destination: URL(string: "https://twitter.com/caaaption")!)
        Link("GitHub", destination: URL(string: "https://github.com/caaaption")!)
        Link("Mirror", destination: URL(string: "https://mirror.xyz/caaaption.eth")!)
        Link("Guild", destination: URL(string: "https://guild.xyz/caaaption")!)
        Link("Discord", destination: URL(string: "https://discord.gg/C3b9hgVnnk")!)
        Link("Lens", destination: URL(string: "https://www.lensfrens.xyz/caaaption.lens")!)
        Link("Widget Request", destination: URL(string: "https://caaaption.com/requests")!)
      }
      .navigationTitle("Links")
      .navigationBarTitleDisplayMode(.inline)
      .toolbar {
        ToolbarItem(placement: .navigationBarTrailing) {
          Button("Done") {
            viewStore.send(.doneButtonTapped)
          }
          .bold()
        }
      }
    }
  }
}

#if DEBUG
  struct LinkViewPreviews: PreviewProvider {
    static var previews: some View {
      NavigationStack {
        LinkView(
          store: .init(
            initialState: LinkReducer.State(),
            reducer: LinkReducer()
          )
        )
      }
    }
  }
#endif
