import AccountFeature
import BalanceWidget
import BalanceWidgetFeature
import ComposableArchitecture
import SwiftUI
import VoteWidget
import VoteWidgetFeature

public struct WidgetSearchView: View {
  let store: StoreOf<WidgetSearchReducer>

  public init(store: StoreOf<WidgetSearchReducer>) {
    self.store = store
  }

  public var body: some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
      List {
        Button {
          viewStore.send(.tapped(.balance))
        } label: {
          ListCard(BalanceWidget.self)
        }

        Button {
          viewStore.send(.tapped(.vote))
        } label: {
          ListCard(VoteWidget.self)
        }
      }
      .listStyle(.plain)
      .navigationTitle("Widget Search")
      .task { await viewStore.send(.task).finish() }
      .refreshable { await viewStore.send(.refreshable).finish() }
      .searchable(
        text: viewStore.binding(\.$searchable),
        placement: .navigationBarDrawer(
          displayMode: .always
        ),
        prompt: "Search Widget"
      )
      .toolbar {
        ToolbarItem(placement: .navigationBarTrailing) {
          Button {
            viewStore.send(.tapped(.account))
          } label: {
            Color.red
              .frame(width: 36, height: 36)
              .clipShape(Circle())
          }
        }
      }
      .sheet(
        store: store.scope(
          state: \.$destination,
          action: WidgetSearchReducer.Action.destination
        ),
        state: /WidgetSearchReducer.Destination.State.account,
        action: WidgetSearchReducer.Destination.Action.account
      ) { store in
        NavigationStack {
          AccountView(store: store)
        }
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
