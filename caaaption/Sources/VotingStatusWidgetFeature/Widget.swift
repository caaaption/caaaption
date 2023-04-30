import SwiftUI
import WidgetKit

public struct VotingStatusWidget: Widget {
  public let kind: String = "VotingStatusWidget"

  public init() {}

  public var body: some WidgetConfiguration {
    StaticConfiguration(kind: kind, provider: Provider()) { entry in
      VotingStatusWidgetView(entry: entry)
    }
    .configurationDisplayName("Voting Status Widget")
    .description("Displays the voting results for the specified Snapshot.")
    .supportedFamilies([.systemMedium])
  }
}
