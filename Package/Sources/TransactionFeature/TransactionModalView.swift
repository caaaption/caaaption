import ComposableArchitecture
import SwiftUI

public struct TransactionModalView: View {
  let store: StoreOf<TransactionModalReducer>

  public init(store: StoreOf<TransactionModalReducer>) {
    self.store = store
  }

  public var body: some View {
    WithViewStore(store, observe: { $0 }) { _ in
    }
  }
}
