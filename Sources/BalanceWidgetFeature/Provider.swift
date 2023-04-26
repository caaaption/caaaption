import WidgetKit

struct Provider: TimelineProvider {
  func placeholder(in context: Context) -> Entry {
    Entry(date: Date(), balance: 1.0)
  }

  func getSnapshot(in context: Context, completion: @escaping (Entry) -> Void) {
    let entry = Entry(date: Date(), balance: 1.0)
    completion(entry)
  }

  func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> Void) {
    getSnapshot(in: context) { entry in
      let timeline = Timeline(entries: [entry], policy: .atEnd)
      completion(timeline)
    }
  }
}
