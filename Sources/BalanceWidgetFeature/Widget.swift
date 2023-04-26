import SwiftUI
import WidgetKit

public struct BalanceWidget: Widget {
  let kind: String = "BalanceWidget"

  public init() {}

  public var body: some WidgetConfiguration {
    StaticConfiguration(kind: kind, provider: Provider()) { entry in
      WidgetView(entry: entry)
    }
    .configurationDisplayName("Check your balance")
    .description("Displays wallet balance.")
    .supportedFamilies([.systemSmall])
  }
}
