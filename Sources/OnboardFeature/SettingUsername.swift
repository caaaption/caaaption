import SwiftUI
import DesignSystem
import ComposableArchitecture

public struct SettingUsernameView: View {
  let store: StoreOf<OnboardReducer>
  @ObservedObject var viewStore: ViewStoreOf<OnboardReducer>
  
  public init(store: StoreOf<OnboardReducer>) {
    self.store = store
    self.viewStore = ViewStore(self.store)
  }
  
  public var body: some View {
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
        text: viewStore.binding(
          get: \.username,
          send: OnboardReducer.Action.changedUsername
        ),
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
