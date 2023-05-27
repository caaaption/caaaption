import SwiftUI
import WidgetKit
import WidgetProtocol

public struct POAPWidget: WidgetProtocol {
  public struct Entrypoint: Widget {
    let kind = Constant.kind
    public init() {}

    public var body: some WidgetConfiguration {
      StaticConfiguration(kind: kind, provider: Provider()) { entry in
        POAPWidget.WidgetView(entry: entry)
      }
      .configurationDisplayName(Constant.displayName)
      .description(Constant.description)
      .supportedFamilies(Constant.supportedFamilies)
    }
  }

  public enum Constant: WidgetConstant {
    public static var displayName = "POAP"
    public static var description = "Show POAP"
    public static var kind = "POAPWidget"
    public static var supportedFamilies: [WidgetFamily] = [
      .systemSmall,
    ]
  }

  public struct Input: Codable {
    public let address: String

    public init(address: String) {
      self.address = address
    }
  }

  public struct Entry: TimelineEntry, Equatable {
    public let date: Date

    public init(
      date: Date
    ) {
      self.date = date
    }
  }

  public struct Provider: TimelineProvider {
    public func placeholder(
      in context: Context
    ) -> Entry {
      Entry(date: Date())
    }

    public func getSnapshot(
      in context: Context,
      completion: @escaping (Entry) -> Void
    ) {
      let entry = Entry(date: Date())
      completion(entry)
    }

    public func getTimeline(
      in context: Context,
      completion: @escaping (Timeline<Entry>) -> Void
    ) {
      getSnapshot(in: context) { entry in
        let timeline = Timeline(entries: [entry], policy: .atEnd)
        completion(timeline)
      }
    }
  }

  public struct WidgetView: View {
    let entry: Entry

    public init(entry: Entry) {
      self.entry = entry
    }

    public var body: some View {
      VStack(spacing: 8) {
        Text("POAP")
      }
    }

    var updatedAt: some View {
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = "HH:mm"
      let dateString = dateFormatter.string(from: entry.date)
      return Text("Updated at \(dateString)")
    }
  }
}

#if DEBUG
  import WidgetHelpers

  struct WidgetViewPreviews: PreviewProvider {
    static var previews: some View {
      WidgetPreview([.systemSmall]) {
        POAPWidget.WidgetView(
          entry: POAPWidget.Entry(
            date: Date()
          )
        )
      }
    }
  }
#endif
