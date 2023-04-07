import SwiftUI
import SwiftUIHelpers
import ComposableArchitecture

public struct DisplayNameView: View {
  let store: StoreOf<OnboardReducer>
  
  public init(store: StoreOf<OnboardReducer>) {
    self.store = store
  }
  
  public var body: some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
      OnboardWrap(
        title: "hi! what’s your name?",
        description: "choose a display name  - this is what your friends on caption will see",
        content: {
          TextField(
            "satoshi nakamoto",
            text: viewStore.binding(\.$displayName)
          )
          .font(.title2)
          .bold()
        },
        footer: {
          HStack {
            Spacer()
            NavigationLink(
              destination: {
                UsernameView(store: store)
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

struct DisplayNameViewPreviews: PreviewProvider {
  static var previews: some View {
    Preview {
      DisplayNameView(
        store: .init(
          initialState: OnboardReducer.State(),
          reducer: OnboardReducer()
        )
      )
    }
  }
}
