import ComposableArchitecture
import SwiftUI
import SwiftUIHelpers

public struct CountryCodeView: View {
  let store: StoreOf<CountryCodeReducer>
  @ObservedObject var viewStore: ViewStoreOf<CountryCodeReducer>

  public init(store: StoreOf<CountryCodeReducer>) {
    self.store = store
    viewStore = ViewStore(self.store)
  }

  public var body: some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
      List {
        ForEach(viewStore.sections.keys.sorted(), id: \.self) { key in
          Section(header: Text(String(key))) {
            ForEach(viewStore.sections[key]!, id: \.self) { country in
              Button(action: {}) {
                HStack {
                  Text(country.prefix)
                  Text(country.name)
                }
              }
            }
          }
        }
      }
      .listStyle(.plain)
      .navigationBarTitleDisplayMode(.inline)
      .navigationTitle("country code")
      .searchable(
        text: viewStore.binding(
          get: \.query,
          send: CountryCodeReducer.Action.searchable
        )
      )
      .task { await viewStore.send(.task).finish() }
    }
  }
}

struct CountryViewPreview: PreviewProvider {
  static var previews: some View {
    Preview {
      CountryCodeView(
        store: .init(
          initialState: CountryCodeReducer.State(),
          reducer: CountryCodeReducer()
            .dependency(\.phoneNumberClient, .liveValue)
        )
      )
    }
  }
}
