import SwiftUI
import WidgetKit
import WidgetProtocol

public enum MirrorWidget: WidgetProtocol {
  public struct Entrypoint: Widget {
    let kind = Constant.kind
    public init() {}

    public var body: some WidgetConfiguration {
      StaticConfiguration(kind: kind, provider: Provider()) { entry in
        MirrorWidget.WidgetView(entry: entry)
      }
      .configurationDisplayName(Constant.displayName)
      .description(Constant.description)
      .supportedFamilies(Constant.supportedFamilies)
    }
  }

  public enum Constant: WidgetConstant {
    public static var displayName = "Show latest mirror post"
    public static var description = "Show the post for the specified Mirror."
    public static var kind = "MirrorWidget"
    public static var supportedFamilies: [WidgetFamily] = [
      .systemSmall,
    ]
  }

  public struct Input: Codable {}

  public struct Entry: TimelineEntry, Equatable {
    public let date: Date

    public init(date: Date) {
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
      VStack(spacing: 4) {
        Color.red
          .frame(height: 78)

        VStack(spacing: 2) {
          Text("Get real-time dApps information on iPhone widgets")
            .multilineTextAlignment(.leading)
            .lineLimit(3)
            .font(.footnote)
            .bold()

          HStack(alignment: .top, spacing: 0) {
            Text("caaaption.eth")
              .font(.caption)
              .foregroundColor(.secondary)
              .frame(maxWidth: .infinity, alignment: .leading)

            Color.pink
              .frame(width: 14, height: 14)
              .clipShape(Circle())
          }
        }
        .frame(maxHeight: .infinity)
        .padding(.horizontal, 16)
        .padding(.bottom, 8)
      }
    }
  }
}

#if DEBUG
  import WidgetHelpers

  struct WidgetViewPreviews: PreviewProvider {
    static var previews: some View {
      WidgetPreview([.systemSmall]) {
        MirrorWidget.WidgetView(
          entry: MirrorWidget.Entry(
            date: Date()
          )
        )
      }
    }
  }
#endif
