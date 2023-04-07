import ComposableArchitecture
import SwiftUI
import SwiftUIHelpers

public struct PhoneNumberView: View {
  let store: StoreOf<OnboardReducer>

  public init(store: StoreOf<OnboardReducer>) {
    self.store = store
  }

  public var body: some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
      OnboardWrap(
        title: "I need your phone number to know it’s you",
        content: {
          TextField(
            "+81 90-1111-1111",
            text: viewStore.binding(\.$phoneNumber)
          )
          .font(.title2)
          .bold()
        },
        footer: {
          HStack {
            Spacer()
            NavigationLink(
              destination: {
                VerificationCodeView(store: store)
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

struct PhoneNumberViewPreviews: PreviewProvider {
  static var previews: some View {
    Preview {
      PhoneNumberView(
        store: .init(
          initialState: OnboardReducer.State(),
          reducer: OnboardReducer()
        )
      )
    }
  }
}
