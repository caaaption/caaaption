import AccountFeature
import BalanceWidget
import BalanceWidgetFeature
import ComposableArchitecture
import SwiftUI

public struct WidgetSearchView: View {
  let store: StoreOf<WidgetSearchReducer>

  public init(store: StoreOf<WidgetSearchReducer>) {
    self.store = store
  }

  public var body: some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
      List {
        NavigationLink {
          BalanceSettingView(
            store: store.scope(
              state: \.balanceSetting,
              action: WidgetSearchReducer.Action.balanceSetting
            )
          )
        } label: {
          ListCard(
            displayName: BalanceWidget.Constant.displayName,
            description: BalanceWidget.Constant.description
          )
        }
        .listRowSeparator(.hidden)
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
            viewStore.send(.binding(.set(\.$isPresented, true)))
          } label: {
            Color.red
              .frame(width: 36, height: 36)
              .clipShape(Circle())
          }
        }
      }
      .sheet(isPresented: viewStore.binding(\.$isPresented)) {
        NavigationStack {
          AccountView(store: store.scope(state: \.account, action: WidgetSearchReducer.Action.account))
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
