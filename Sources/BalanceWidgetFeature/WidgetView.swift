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

      updatedAt
      .foregroundColor(Color.secondary)
      .font(Font.caption)
    }
    .frame(maxWidth: CGFloat.infinity, maxHeight: CGFloat.infinity)
    .padding()
  }
  
  var updatedAt: some View {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "HH:mm"
    let dateString = dateFormatter.string(from: entry.date)
    return Text("Updated at \(dateString)")
  }
}

struct BalanceWidgetViewPreviews: PreviewProvider {
  static var previews: some View {
    WidgetPreview([.systemSmall]) {
      BalanceWidgetView(entry: Entry(date: Date(), balance: 1.0))
    }
  }
}
