import AnalyticsReducer
import BalanceWidget
import BalanceWidgetFeature
import ComposableArchitecture
import POAPWidget
import POAPWidgetFeature
import SwiftUI
import VoteWidget
import VoteWidgetFeature

public struct WidgetSearchReducer: ReducerProtocol {
  public init() {}

  public struct State: Equatable {
    @PresentationState public var destination: Destination.State?
    public init() {}
  }

  public enum Action: Equatable {
    case destination(PresentationAction<Destination.Action>)
    case helpButtonTapped
    case founderButtonTapped
    case leadDevButtonTapped
    case balanceButtonTapped
    case voteButtonTapped
    case poapButtonTapped
  }

  @Dependency(\.mainQueue) var mainQueue
  @Dependency(\.openURL) var openURL

  public var body: some ReducerProtocol<State, Action> {
    AnalyticsReducer { state, action in
      switch action {
      case .destination:
        return .none
      case .helpButtonTapped:
        return .event(name: "HelpButtonTapped")
      case .founderButtonTapped:
        return .event(name: "FounderButtonTapped")
      case .leadDevButtonTapped:
        return .event(name: "LeadDevButtonTapped")
      case .balanceButtonTapped:
        return .event(name: "BalanceButtonTapped")
      case .voteButtonTapped:
        return .event(name: "VoteButtonTapped")
      case .poapButtonTapped:
        return .event(name: "POAPButtonTapped")
      }
    }
    Reduce { state, action in
      switch action {
      case .destination:
        return .none

      case .helpButtonTapped:
        return .run { _ in
          let url = URL(string: "https://caaaption.notion.site/How-to-setup-my-widgets-Add-the-caaaption-widget-to-your-iPhone-home-screen-892061686c154b72ae6b4230329466b6")!
          await self.openURL(url)
        }

      case .founderButtonTapped:
        return .run { _ in
          let url = URL(string: "https://twitter.com/0xsatoya")!
          await self.openURL(url)
        }

      case .leadDevButtonTapped:
        return .run { _ in
          let url = URL(string: "https://twitter.com/tomokisun")!
          await self.openURL(url)
        }

      case .balanceButtonTapped:
        state.destination = .balance()
        return .none

      case .voteButtonTapped:
        state.destination = .vote()
        return .none

      case .poapButtonTapped:
        state.destination = .poap()
        return .none
      }
    }
    .ifLet(\.$destination, action: /Action.destination) {
      Destination()
    }
  }
}

public extension WidgetSearchReducer {
  struct Destination: ReducerProtocol {
    public enum State: Equatable {
      case balance(BalanceSettingReducer.State = .init())
      case vote(SpacesReducer.State = .init())
      case poap(MyPOAPReducer.State = .init())
    }

    public enum Action: Equatable {
      case balance(BalanceSettingReducer.Action)
      case vote(SpacesReducer.Action)
      case poap(MyPOAPReducer.Action)
    }

    public var body: some ReducerProtocol<State, Action> {
      Scope(state: /State.balance, action: /Action.balance) {
        BalanceSettingReducer()
      }
      Scope(state: /State.vote, action: /Action.vote) {
        SpacesReducer()
      }
      Scope(state: /State.poap, action: /Action.poap) {
        MyPOAPReducer()
      }
    }
  }
}

public struct WidgetSearchView: View {
  let store: StoreOf<WidgetSearchReducer>

  public init(store: StoreOf<WidgetSearchReducer>) {
    self.store = store
  }

  public var body: some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
      List {
        Section("Help") {
          Button {
            viewStore.send(.helpButtonTapped)
          } label: {
            Label(
              "How to setup my widgets",
              systemImage: "questionmark.circle"
            )
          }

          Button {
            viewStore.send(.founderButtonTapped)
          } label: {
            Label {
              Text("Talk to Founder!")
            } icon: {
              Text("👋")
            }
          }

          Button {
            viewStore.send(.leadDevButtonTapped)
          } label: {
            Label {
              Text("Talk to LeadDev!")
            } icon: {
              Text("👨🏻‍💻")
            }
          }
        }

        Section("Widgets") {
          Button {
            viewStore.send(.balanceButtonTapped)
          } label: {
            ListCard(BalanceWidget.self)
          }
          .sheet(
            store: store.scope(
              state: \.$destination,
              action: WidgetSearchReducer.Action.destination
            ),
            state: /WidgetSearchReducer.Destination.State.balance,
            action: WidgetSearchReducer.Destination.Action.balance
          ) { store in
            NavigationStack {
              BalanceSettingView(store: store)
            }
          }

          Button {
            viewStore.send(.voteButtonTapped)
          } label: {
            ListCard(VoteWidget.self)
          }
          .sheet(
            store: store.scope(
              state: \.$destination,
              action: WidgetSearchReducer.Action.destination
            ),
            state: /WidgetSearchReducer.Destination.State.vote,
            action: WidgetSearchReducer.Destination.Action.vote
          ) { store in
            NavigationStack {
              SpacesView(store: store)
            }
          }

          Button {
            viewStore.send(.poapButtonTapped)
          } label: {
            ListCard(POAPWidget.self)
          }
          .sheet(
            store: store.scope(
              state: \.$destination,
              action: WidgetSearchReducer.Action.destination
            ),
            state: /WidgetSearchReducer.Destination.State.poap,
            action: WidgetSearchReducer.Destination.Action.poap
          ) { store in
            NavigationStack {
              MyPOAPView(store: store)
            }
          }
        }
      }
      .navigationTitle("Widgets")
    }
  }
}

#if DEBUG
  import SwiftUIHelpers

  struct WidgetSearchViewPreviews: PreviewProvider {
    static var previews: some View {
      Preview {
        NavigationStack {
          WidgetSearchView(
            store: .init(
              initialState: WidgetSearchReducer.State(),
              reducer: WidgetSearchReducer()
            )
          )
        }
      }
    }
  }
#endif
