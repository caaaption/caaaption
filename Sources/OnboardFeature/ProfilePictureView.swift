import ComposableArchitecture
import SwiftUI

struct ProfilePictureView: View {
  let store: StoreOf<OnboardReducer>

  var body: some View {
    WithViewStore(store, observe: { $0 }) { _ in
      OnboardWrap(
        title: "nice! set your profile picture",
        description: "Choose a username so your friends can find your easily",
        content: {},
        footer: {
          NavigationLink(
            destination: {},
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
