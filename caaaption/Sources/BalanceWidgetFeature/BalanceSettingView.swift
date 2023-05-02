import ComposableArchitecture
import SwiftUI

public struct BalanceSettingView: View {
  let store: StoreOf<BalanceSettingReducer>

  public init(store: StoreOf<BalanceSettingReducer>) {
    self.store = store
  }

  public var body: some View {
    WithViewStore(store, observe: { $0 }) { _ in
    }
  }
}
