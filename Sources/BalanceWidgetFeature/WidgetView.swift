import SwiftUI
import WidgetKit

public struct WidgetView: View {
  public var entry: Entry

  public init(entry: Entry) {
    self.entry = entry
  }

  public var body: some View {
    VStack(spacing: 12) {
      Text("Balance")
        .font(.headline)
      Text(entry.balance.description.prefix(6) + "ETH")
        .font(.title2)
        .bold()
        .foregroundColor(.blue)
    }
  }
}

struct WidgetViewPreviews: PreviewProvider {
  static var previews: some View {
    WidgetView(entry: Entry(date: Date(), balance: 1.0))
      .previewContext(WidgetPreviewContext(family: .systemSmall))
  }
}
