import SwiftUI
import ComposableArchitecture

struct ConnectToWalletView: View {
  let store: StoreOf<OnboardReducer>
  
  var body: some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
      OnboardWrap(
        title: "can you connect me with crypto wallet?",
        description: "if you connect,  I can even post your purchases that you paid for with crypto currency",
        content: {
          
        },
        footer: {
          NavigationLink(
            destination: {
              ProfilePictureView(store: store)
            },
            label: {
              Color.green
                .frame(height: 48)
                .frame(maxWidth: .infinity)
                .cornerRadius(6)
            }
          )
        }
      )
    }
  }
}
