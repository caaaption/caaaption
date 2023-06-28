import AccountFeature
import ComposableArchitecture
import ContributorFeature
import LinkFeature
import SwiftUI
import WidgetSearchFeature
import LicenseFeature

public struct WidgetTabReducer: ReducerProtocol {
  public init() {}

  public struct State: Equatable {
    var widgetSearch = WidgetSearchReducer.State()

    @PresentationState var destination: Destination.State?
    public init() {}
  }

  public enum Action: Equatable {
    case widgetSearch(WidgetSearchReducer.Action)
    case destination(PresentationAction<Destination.Action>)
    case contributorButtonTapped
    case linkButtonTapped
    case licenseButtonTapped
  }

  public var body: some ReducerProtocol<State, Action> {
    Scope(state: \.widgetSearch, action: /Action.widgetSearch) {
      WidgetSearchReducer()
    }
    Reduce { state, action in
      switch action {
      case .widgetSearch:
        return .none

      case .destination:
        return .none

      case .contributorButtonTapped:
        state.destination = .contributor()
        return .none

      case .linkButtonTapped:
        state.destination = .link()
        return .none
        
      case .licenseButtonTapped:
        state.destination = .license()
        return .none
      }
    }
    .ifLet(\.$destination, action: /Action.destination) {
      Destination()
    }
  }

  public struct Destination: ReducerProtocol {
    public enum State: Equatable {
      case contributor(ContributorReducer.State = .init())
      case link(LinkReducer.State = .init())
      case license(LicenseReducer.State = .init())
    }

    public enum Action: Equatable {
      case contributor(ContributorReducer.Action)
      case link(LinkReducer.Action)
      case license(LicenseReducer.Action)
    }

    public var body: some ReducerProtocol<State, Action> {
      Scope(state: /State.contributor, action: /Action.contributor) {
        ContributorReducer()
      }
      Scope(state: /State.link, action: /Action.link) {
        LinkReducer()
      }
      Scope(state: /State.license, action: /Action.license) {
        LicenseReducer()
      }
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
            Button {
              viewStore.send(.licenseButtonTapped)
            } label: {
              Label("License", systemImage: "shippingbox")
            }
          } label: {
            Image(systemName: "gearshape.fill")
          }
        }
      }
      .sheet(
        store: store.scope(state: \.$destination, action: { .destination($0) })
      ) { store in
        SwitchStore(store) {
          switch $0 {
          case .contributor:
            CaseLet(
              /WidgetTabReducer.Destination.State.contributor,
              action: WidgetTabReducer.Destination.Action.contributor,
              then: ContributorView.init(store:)
            )
          case .link:
            CaseLet(
              /WidgetTabReducer.Destination.State.link,
              action: WidgetTabReducer.Destination.Action.link,
              then: LinkView.init(store:)
            )
          case .license:
            CaseLet(
              /WidgetTabReducer.Destination.State.license,
              action: WidgetTabReducer.Destination.Action.license,
              then: LicenseView.init(store:)
            )
          }
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
