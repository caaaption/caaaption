import ComposableArchitecture
import SwiftUI
import BalanceWidget

public struct BalanceSettingView: View {
  let store: StoreOf<BalanceSettingReducer>
  
  public init(store: StoreOf<BalanceSettingReducer>) {
    self.store = store
  }
  
  public var body: some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
      VStack(spacing: 12) {
        Spacer()
        
        if let entry = viewStore.entry {
          BalanceWidget.WidgetView(entry: entry)
        }
        
        Spacer()
        
        TextField(
          "Search addresses",
          text: viewStore.binding(\.$address)
        )
        
        Button(action: { viewStore.send(.addWidget) }) {
          HStack {
            Image(systemName: "plus.circle.fill")
              .tint(Color.white)
            Text("Add Widget")
              .bold()
              .foregroundColor(Color.white)
          }
          .frame(height: 50, alignment: .center)
          .frame(maxWidth: CGFloat.infinity)
          .background(Color.blue)
          .clipShape(Capsule())
        }
      }
      .padding(.horizontal, 12)
    }
  }
}

#if DEBUG
import SwiftUIHelpers

struct BalanceSettingViewPreviews: PreviewProvider {
  static var previews: some View {
    Preview {
      BalanceSettingView(
        store: .init(
          initialState: BalanceSettingReducer.State(),
          reducer: BalanceSettingReducer()
        )
      )
    }
  }
}
#endif
