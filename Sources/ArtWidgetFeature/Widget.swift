import WidgetKit
import SwiftUI

public struct ArtWidget: Widget {
  let kind: String = "ArtWidget"
  
  public init() {}
  
  public var body: some WidgetConfiguration {
    StaticConfiguration(kind: kind, provider: Provider()) { entry in
      WidgetView(entry: entry)
    }
    .configurationDisplayName("NFT Widget")
    .description("Displays the NFT selected in the application.")
  }
}

