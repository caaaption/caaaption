import ComposableArchitecture
import SwiftUI

struct VerificationCodeView: View {
  let store: StoreOf<OnboardReducer>

  @Environment(\.dismiss) private var dismiss

  var body: some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
      OnboardWrap(
        title: "now enter the code I sent you",
        description: "sent to \(viewStore.phoneNumber)",
        content: {
          TextField(
            "000000",
            text: viewStore.binding(\.$verificationCode)
          )
          .font(.title2)
          .bold()
        },
        footer: {
          HStack {
            Spacer()
            HStack {
              Button(action: { dismiss() }) {
                Color.systemGray5
                  .frame(width: 48, height: 48)
                  .cornerRadius(6)
              }

              Text("you can ask for a new\ncode in 29 seconds :)")
                .foregroundColor(.systemGray2)
                .font(.caption)
                .fontWeight(.medium)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity)

              NavigationLink(
                destination: {
                  DisplayNameView(store: store)
                },
                label: {
                  Color.green
                    .frame(width: 48, height: 48)
                    .cornerRadius(6)
                }
              )
            }
          }
        }
      )
    }
  }
}

struct VerificationCodeViewPreviews: PreviewProvider {
  static var previews: some View {
    VerificationCodeView(
      store: .init(
        initialState: OnboardReducer.State(),
        reducer: OnboardReducer()
      )
    )
  }
}
