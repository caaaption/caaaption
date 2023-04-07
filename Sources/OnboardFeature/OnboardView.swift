import SwiftUI
import ComposableArchitecture

public struct OnboardView: View {
  let store: StoreOf<OnboardReducer>
  
  public init(store: StoreOf<OnboardReducer>) {
    self.store = store
  }
  
  public var body: some View {
    NavigationStack {
      PhoneNumberView(store: store)
    }
  }
}
