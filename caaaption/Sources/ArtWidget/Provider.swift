import WidgetKit

let imageUrl = "https://pbs.twimg.com/profile_images/1528599200132259841/G1fUHZQ9_400x400.jpg"

struct Provider: TimelineProvider {
  func placeholder(in context: Context) -> Entry {
    Entry(date: Date(), url: imageUrl)
  }

  func getSnapshot(in context: Context, completion: @escaping (Entry) -> Void) {
    let entry = Entry(date: Date(), url: imageUrl)
    completion(entry)
  }

  func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> Void) {
    getSnapshot(in: context) { entry in
      let timeline = Timeline(entries: [entry], policy: .atEnd)
      completion(timeline)
    }
  }
}
