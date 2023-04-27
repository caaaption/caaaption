import SwiftUI
import WidgetHelpers
import WidgetKit

public struct BalanceWidgetView: View {
  public var entry: Entry

  public init(entry: Entry) {
    self.entry = entry
  }

  public var body: some View {
    VStack(spacing: 8) {
      Spacer()
      Text("Balance")
        .font(Font.headline)

      Text("\(entry.balance.description) ETH")
        .font(Font.title2)
        .bold()
        .foregroundColor(Color.blue)

      Spacer()

      Text("Updated at 20:00")
      .foregroundColor(Color.secondary)
      .font(Font.caption)
    }
    .frame(maxWidth: CGFloat.infinity, maxHeight: CGFloat.infinity)
    .padding()
  }
}

struct BalanceWidgetViewPreviews: PreviewProvider {
  static var previews: some View {
    WidgetPreview([.systemSmall]) {
      BalanceWidgetView(entry: Entry(date: Date(), balance: 1.0))
    }
  }
}
