import ComposableArchitecture
import SwiftUI
import CollectionFeature
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
          
          Spacer().frame(height: 120)
          
          NavigationLink(
            destination: {
              CollectionView(
                store: store.scope(
                  state: \.collection,
                  action: ProfileReducer.Action.collection
                )
              )
            },
            label: {
              Text("Collections")
            }
          )
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
