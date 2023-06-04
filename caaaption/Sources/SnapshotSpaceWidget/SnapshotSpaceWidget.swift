import SwiftUI
import WidgetKit
import WidgetProtocol

public enum SnapshotSpaceWidget: WidgetProtocol {
  public struct Entrypoint: Widget {
    let kind = Constant.kind
    public init() {}

    public var body: some WidgetConfiguration {
      StaticConfiguration(kind: kind, provider: Provider()) { entry in
        SnapshotSpaceWidget.WidgetView(entry: entry)
      }
      .configurationDisplayName(Constant.displayName)
      .description(Constant.description)
      .supportedFamilies(Constant.supportedFamilies)
    }
  }

  public enum Constant: WidgetConstant {
    public static var displayName = "Show snapshot spaces"
    public static var description = "Show the spaces for the specified Snapshot."
    public static var kind = "SnapshotSpaceWidget"
    public static var supportedFamilies: [WidgetFamily] = [
      .systemMedium,
    ]
  }

  public struct Input: Codable {}

  public struct Entry: TimelineEntry, Equatable {
    public let date: Date
    public let spaces: [Space]

    public init(date: Date, spaces: [Space]) {
      self.date = date
      self.spaces = spaces
    }
    
    public struct Space: Codable, Equatable {
      let imageData: Data
      let name: String
      let members: String
    }
  }

  public struct Provider: TimelineProvider {
    public func placeholder(
      in context: Context
    ) -> Entry {
      Entry(date: Date(), spaces: [])
    }

    public func getSnapshot(
      in context: Context,
      completion: @escaping (Entry) -> Void
    ) {
      let entry = Entry(
        date: Date(),
        spaces: [
          Entry.Space(
            imageData: try! Data(contentsOf: URL(string: "https://cdn.stamp.fyi/space/opcollective.eth")!),
            name: "Optimism",
            members: "152K\nmembers"
          ),
          Entry.Space(
            imageData: try! Data(contentsOf: URL(string: "https://cdn.stamp.fyi/space/aave.eth")!),
            name: "Aave",
            members: "112K\nmembers"
          ),
          Entry.Space(
            imageData: try! Data(contentsOf: URL(string: "https://cdn.stamp.fyi/space/uniswap")!),
            name: "Friends with Benefits",
            members: "152K\nmembers"
          ),
          Entry.Space(
            imageData: try! Data(contentsOf: URL(string: "https://cdn.stamp.fyi/space/friendswithbenefits.eth")!),
            name: "Uniswap",
            members: "98K\nmembers"
          ),
        ]
      )
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
      VStack(spacing: 12) {
        HStack(spacing: 0) {
          Text("Spaces")
            .frame(maxWidth: .infinity, alignment: .leading)
            .bold()
        }
        LazyVGrid(
          columns: Array(repeating: GridItem(), count: 4),
          spacing: 12
        ) {
          ForEach(0..<entry.spaces.count, id: \.self) { index in
            VStack(alignment: .center, spacing: 6) {
              Image(uiImage: UIImage(data: entry.spaces[index].imageData)!)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 48, height: 48)
                .clipShape(Circle())
              
              Text(entry.spaces[index].name)
                .bold()
                .font(.callout)
                .lineLimit(1)
              
              Text(entry.spaces[index].members)
                .font(.caption)
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
            }
          }
        }
      }
      .padding(.all, 16)
    }
  }
}

#if DEBUG
  import WidgetHelpers

  struct WidgetViewPreviews: PreviewProvider {
    static var previews: some View {
      WidgetPreview([.systemMedium]) {
        SnapshotSpaceWidget.WidgetView(
          entry: SnapshotSpaceWidget.Entry(
            date: Date(),
            spaces: []
          )
        )
      }
    }
  }
#endif
