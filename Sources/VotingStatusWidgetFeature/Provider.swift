import Dependencies
import SnapshotClient
import WidgetKit

struct Provider: TimelineProvider {
  @Dependency(\.snapshotClient) var snapshotClient

  func placeholder(in context: Context) -> Entry {
    Entry(date: Date(), proposal: nil)
  }

  func getSnapshot(in context: Context, completion: @escaping (Entry) -> Void) {
    Task {
      do {
        let result = try await snapshotClient.proposal("0x4421dddc830355b7e3f5290fb9583ded426e61450fe0bd2742722b3d87db288f")
        let entry = Entry(date: Date(), proposal: result.data?.proposal)
        completion(entry)
      } catch {
        let entry = Entry(date: Date(), proposal: nil)
        completion(entry)
      }
    }
  }

  func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> Void) {
    getSnapshot(in: context) { entry in
      let timeline = Timeline(entries: [entry], policy: .atEnd)
      completion(timeline)
    }
  }
}
