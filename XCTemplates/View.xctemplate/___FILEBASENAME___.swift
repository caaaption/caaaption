import ComposableArchitecture
import SwiftUI

public struct ___VARIABLE_productName:identifier___View: View {
  let store: StoreOf<___VARIABLE_productName:identifier___Reducer>

  public init(store: StoreOf<___VARIABLE_productName:identifier___Reducer>) {
    self.store = store
  }

  public var body: some View {
    WithViewStore(store, observe: { $0 }) { _ in
    }
  }
}
