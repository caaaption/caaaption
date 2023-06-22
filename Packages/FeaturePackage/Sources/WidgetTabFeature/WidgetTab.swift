import AccountFeature
import ComposableArchitecture
import SwiftUI
import WidgetSearchFeature
import ContributorFeature
import LinkFeature

public struct WidgetTabReducer: ReducerProtocol {
  public init() {}

  public struct State: Equatable {
    var widgetSearch = WidgetSearchReducer.State()

    @PresentationState var contributor: ContributorReducer.State?
    @PresentationState var link: LinkReducer.State?
    public init() {}
  }

  public enum Action: Equatable {
    case widgetSearch(WidgetSearchReducer.Action)
    case contributor(PresentationAction<ContributorReducer.Action>)
    case link(PresentationAction<LinkReducer.Action>)
    case contributorButtonTapped
    case linkButtonTapped
  }

  public var body: some ReducerProtocol<State, Action> {
    Scope(state: \.widgetSearch, action: /Action.widgetSearch) {
      WidgetSearchReducer()
    }
    Reduce { state, action in
      switch action {
      case .widgetSearch:
        return .none

      case .contributor:
        return .none
        
      case .link:
        return .none

      case .contributorButtonTapped:
        state.contributor = .init()
        return .none
        
      case .linkButtonTapped:
        state.link = .init()
        return .none
      }
    }
    .ifLet(\.$contributor, action: /Action.contributor) {
      ContributorReducer()
    }
    .ifLet(\.$link, action: /Action.link) {
      LinkReducer()
    }
  }
}

public struct WidgetTabView: View {
  let store: StoreOf<WidgetTabReducer>

  public init(store: StoreOf<WidgetTabReducer>) {
    self.store = store
  }

  public var body: some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
      WidgetSearchView(
        store: store.scope(
          state: \.widgetSearch,
          action: WidgetTabReducer.Action.widgetSearch
        )
      )
      .toolbar {
        ToolbarItem(placement: .navigationBarTrailing) {
          Menu {
            Button {
              viewStore.send(.contributorButtonTapped)
            } label: {
              Label("Contributors", systemImage: "person.3")
            }
            Button {
              viewStore.send(.linkButtonTapped)
            } label: {
              Label("Links", systemImage: "link")
            }
          } label: {
            Image(systemName: "gearshape.fill")
          }
        }
      }
      .sheet(
        store: store.scope(
          state: \.$contributor,
          action: WidgetTabReducer.Action.contributor
        )
      ) { store in
        NavigationStack {
          ContributorView(store: store)
        }
      }
      .sheet(
        store: store.scope(
          state: \.$link,
          action: WidgetTabReducer.Action.link
        )
      ) { store in
        NavigationStack {
          LinkView(store: store)
        }
      }
    }
  }
}

#if DEBUG
  import SwiftUIHelpers

  struct WidgetTabViewPreviews: PreviewProvider {
    static var previews: some View {
      Preview {
        NavigationStack {
          WidgetTabView(
            store: .init(
              initialState: WidgetTabReducer.State(),
              reducer: WidgetTabReducer()
            )
          )
        }
      }
    }
  }
#endif
