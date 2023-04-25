import WidgetKit
import SwiftUI
import ArtWidgetFeature

typealias SimpleEntry = ArtWidgetEntry
let imageUrl = "https://pbs.twimg.com/profile_images/1528599200132259841/G1fUHZQ9_400x400.jpg"

struct Provider: TimelineProvider {
  func placeholder(in context: Context) -> SimpleEntry {
    SimpleEntry(date: Date(), url: imageUrl)
  }
  
  func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
    let entry = SimpleEntry(date: Date(), url: imageUrl)
    completion(entry)
  }
  
  func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
    getSnapshot(in: context) { entry in
      let timeline = Timeline(entries: [entry], policy: .atEnd)
      completion(timeline)
    }
  }
}

struct ArtWidget: Widget {
  let kind: String = "ArtWidget"
  
  var body: some WidgetConfiguration {
    StaticConfiguration(kind: kind, provider: Provider()) { entry in
      ArtWidgetView(entry: entry)
    }
    .configurationDisplayName("NFT Widget")
    .description("Displays the NFT selected in the application.")
  }
}

struct ArtWidget_Previews: PreviewProvider {
  static var previews: some View {
    ArtWidgetView(entry: SimpleEntry(date: Date(), url: imageUrl))
      .previewContext(WidgetPreviewContext(family: .systemSmall))
  }
}

