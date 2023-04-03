import ComposableArchitecture
import DesignSystem
import SwiftUI

public struct SettingUsernameView: View {
  let store: StoreOf<OnboardReducer>

  public init(store: StoreOf<OnboardReducer>) {
    self.store = store
  }

  public var body: some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
      VStack(alignment: .leading, spacing: 20) {
        Text("\(viewStore.displayName)! let's pick a username?")
          .font(.largeTitle)
          .bold()
          .padding(.top, 20)
        Text("Choose a username so your friends can find your easily")
          .bold()
          .font(.headline)
          .foregroundColor(.secondary)

        TextField(
          text: viewStore.binding(\.$username),
          label: { Text("username").bold() }
        )
        .autocapitalization(.none)
        .keyboardType(.asciiCapable)
        .font(.title)
        .bold()
        StatusLabel(status: .available("That username is avaliable!"))
        Spacer()
        TextButton("Next", action: {})
          .padding(.bottom, 20)
      }
      .padding(.horizontal, 20)
      .toolbarRole(.editor)
    }
  }
}
