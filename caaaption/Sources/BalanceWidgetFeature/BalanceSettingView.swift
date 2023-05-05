import BalanceWidget
import ComposableArchitecture
import SwiftUI

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
      .task { await viewStore.send(.task).finish() }
      .padding(.horizontal, 12)
      .navigationTitle("Balance Widget")
      .navigationBarTitleDisplayMode(.inline)
      .toolbar {
        ToolbarItem(placement: .navigationBarTrailing) {
          Button {
            viewStore.send(.dismiss)
          } label: {
            Image(systemName: "xmark.circle.fill")
              .symbolRenderingMode(.palette)
              .foregroundStyle(.gray, .bar)
              .font(.system(size: 30))
          }
        }
      }
    }
  }
}

#if DEBUG
  import SwiftUIHelpers

  struct BalanceSettingViewPreviews: PreviewProvider {
    static var previews: some View {
      Preview {
        NavigationStack {
          BalanceSettingView(
            store: .init(
              initialState: BalanceSettingReducer.State(),
              reducer: BalanceSettingReducer()
            )
          )
        }
      }
    }
  }
#endif
