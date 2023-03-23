import SwiftUI
import DesignSystem
import ComposableArchitecture

public struct SettingDisplayNameView: View {
  let store: StoreOf<OnboardReducer>
  @ObservedObject var viewStore: ViewStoreOf<OnboardReducer>

  public init(store: StoreOf<OnboardReducer>) {
    self.store = store
    self.viewStore = ViewStore(self.store)
  }
  
  public var body: some View {
    VStack(alignment: .leading) {
      SizedBox(height: 20)
      Text("hi! what's your name?")
        .font(.largeTitle)
        .bold()
      SizedBox(height: 20)
      Text("Choose a display name - this is what your friends on Caption will see")
        .bold()
        .font(.headline)
        .foregroundColor(.secondary)
      SizedBox(height: 20)
      TextField(
        text: viewStore.binding(
          get: \.displayName,
          send: OnboardReducer.Action.changedDisplayName
        ),
        label: { Text("display name").bold() }
      )
      .autocapitalization(.none)
      .font(.title)
      .bold()
      Spacer()
      
      NavigationLink(
        destination: {
          SettingUsernameView(store: store)
        },
        label: {
          TextButton("Next", action: {})
            .disabled(true)
        }
      )
      .padding(.bottom, 20)
    }
    .padding(.horizontal, 20)
    .toolbarRole(.editor)
  }
}
