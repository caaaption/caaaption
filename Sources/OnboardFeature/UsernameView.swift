import ComposableArchitecture
import SwiftUI

struct UsernameView: View {
  let store: StoreOf<OnboardReducer>

  init(store: StoreOf<OnboardReducer>) {
    self.store = store
  }

  var body: some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
      OnboardWrap(
        title: "tomoki! let’s pick a username?",
        description: "choose a username so your friends can find your easily",
        content: {
          TextField(
            "@username",
            text: viewStore.binding(\.$username)
          )
          .font(.title2)
          .bold()
        },
        footer: {
          HStack {
            Spacer()

            NavigationLink(
              destination: {
                ConnectToWalletView(store: store)
              },
              label: {
                Color.green
                  .frame(width: 48, height: 48)
                  .cornerRadius(6)
              }
            )
          }
        }
      )
    }
  }
}
