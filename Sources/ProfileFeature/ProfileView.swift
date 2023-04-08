import ComposableArchitecture
import SwiftUI
import SwiftUIHelpers

public struct ProfileView: View {
  let store: StoreOf<ProfileReducer>

  public init(store: StoreOf<ProfileReducer>) {
    self.store = store
  }

  public var body: some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
      ScrollView {
        VStack {
          HeaderView(store: store.scope(state: \.header, action: ProfileReducer.Action.header))
        }
      }
      .edgesIgnoringSafeArea(.all)
    }
  }
}

struct ProfileViewPreview: PreviewProvider {
  static var previews: some View {
    Preview {
      ProfileView(
        store: .init(
          initialState: ProfileReducer.State(),
          reducer: ProfileReducer()
        )
      )
    }
  }
}
