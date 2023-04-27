import SwiftUI
import WidgetKit

public struct BalanceWidget: Widget {
  let kind: String = "BalanceWidget"

  public init() {}

  public var body: some WidgetConfiguration {
    StaticConfiguration(kind: kind, provider: Provider()) { entry in
      BalanceWidgetView(entry: entry)
    }
    .configurationDisplayName("Balance Widget")
    .description("Displays wallet balance.")
    .supportedFamilies([.systemSmall])
  }
}
