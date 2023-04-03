import ComposableArchitecture
import DesignSystem
import SwiftUI

public struct LaunchView: View {
  let store: StoreOf<OnboardReducer>
  @ObservedObject var viewStore: ViewStoreOf<OnboardReducer>

  public init(store: StoreOf<OnboardReducer>) {
    self.store = store
    viewStore = ViewStore(self.store)
  }

  @State var isSheetPresented = false
  @State var selection: PresentationDetent = .large

  public var body: some View {
    NavigationStack {
      VStack {
        Spacer()
        TextButton("Country Code") {
          isSheetPresented.toggle()
        }
        NavigationLink(
          destination: {
            SettingDisplayNameView(store: store)
          },
          label: {
            TextButton("Let's Caption App", action: {})
              .disabled(true)
          }
        )
        .padding(.bottom, 20)
      }
      .padding(.horizontal, 20)
      .sheet(isPresented: $isSheetPresented) {
        NavigationStack {
          CountryCodeView(store: store.scope(state: \.countryCode, action: OnboardReducer.Action.countryCode))
        }
        .presentationDetents([.medium, .large], selection: $selection)
      }
    }
  }
}
