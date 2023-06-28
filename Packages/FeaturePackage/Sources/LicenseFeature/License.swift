import ComposableArchitecture
import SwiftUI
import LicenseList

public struct LicenseReducer: ReducerProtocol {
  public init() {}

  public struct State: Equatable {
    public init() {}
  }

  public enum Action: Equatable {
    case dismissButtonTapped
  }
  
  @Dependency(\.dismiss) var dismiss

  public var body: some ReducerProtocol<State, Action> {
    Reduce { _, action in
      switch action {
      case .dismissButtonTapped:
        return .run { _ in
          await self.dismiss()
        }
      }
    }
  }
}

public struct LicenseView: View {
  let store: StoreOf<LicenseReducer>

  public init(store: StoreOf<LicenseReducer>) {
    self.store = store
  }

  public var body: some View {
    NavigationStack {
      LicenseListView()
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("License")
        .toolbar {
          ToolbarItem(placement: .navigationBarTrailing) {
            Button("Done") {
              ViewStore(store).send(.dismissButtonTapped)
            }
            .bold()
          }
        }
    }
  }
}

#if DEBUG
  struct LicenseViewPreviews: PreviewProvider {
    static var previews: some View {
      LicenseView(
        store: .init(
          initialState: LicenseReducer.State(),
          reducer: LicenseReducer()
        )
      )
    }
  }
#endif
