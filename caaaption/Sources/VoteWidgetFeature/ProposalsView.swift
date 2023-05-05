import ComposableArchitecture
import SwiftUI

public struct ProposalsView: View {
  let store: StoreOf<ProposalsReducer>

  public init(store: StoreOf<ProposalsReducer>) {
    self.store = store
  }

  public var body: some View {
    WithViewStore(store, observe: { $0 }) { _ in
    }
  }
}
