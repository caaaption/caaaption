import Dependencies
import SnapshotClient
import SwiftUI
import UserDefaultsClient
import WidgetKit
import WidgetProtocol

public enum VoteWidget: WidgetProtocol {
  public struct Entrypoint: Widget {
    let kind = Constant.kind
    public init() {}

    public var body: some WidgetConfiguration {
      StaticConfiguration(kind: kind, provider: Provider()) { entry in
        VoteWidget.WidgetView(entry: entry)
      }
      .configurationDisplayName(Constant.displayName)
      .description(Constant.description)
      .supportedFamilies(Constant.supportedFamilies)
    }
  }

  public enum Constant: WidgetConstant {
    public static var displayName = "Show voting status"
    public static var description = "Displays the vote result for the specified Snapshot."
    public static var kind = "VoteWidget"
    public static var supportedFamilies: [WidgetFamily] = [
      .systemSmall,
      .systemMedium,
    ]
  }

  public struct Input: Codable {
    public let proposalId: String

    public init(proposalId: String) {
      self.proposalId = proposalId
    }
  }

  public struct Entry: TimelineEntry, Equatable {
    public let date: Date
    public let scores: [Double]

    public init(date: Date, scores: [Double]) {
      self.date = date
      self.scores = scores
    }
  }

  public struct Provider: TimelineProvider {
    @Dependency(\.userDefaults) var userDefaults
    @Dependency(\.snapshotClient) var snapshotClient

    public func placeholder(
      in context: Context
    ) -> Entry {
      Entry(date: Date(), scores: [1, 1])
    }

    public func getSnapshot(
      in context: Context,
      completion: @escaping (Entry) -> Void
    ) {
      guard
        let input = try? userDefaults.codableForKey(Input.self, forKey: Constant.kind)
      else {
        completion(placeholder(in: context))
        return
      }

      Task {
        for try await data in snapshotClient.proposal(input.proposalId) {
          let scores = data.proposal?.scores?.compactMap { $0 } ?? []
          let entry = Entry(date: Date(), scores: scores)
          completion(entry)
        }
      }
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
    @Environment(\.widgetFamily) var widgetFamily

    public init(entry: Entry) {
      self.entry = entry
    }

    public var body: some View {
      HStack(alignment: .top, spacing: 12) {
        CircleGraf(scores: entry.scores)
          .scaleEffect(0.35)
      }
    }
  }
}

#if DEBUG
  import WidgetHelpers

  struct WidgetViewPreviews: PreviewProvider {
    static var previews: some View {
      WidgetPreview([.systemSmall, .systemMedium]) {
        VoteWidget.WidgetView(
          entry: VoteWidget.Entry(
            date: Date(),
            scores: [1, 1]
          )
        )
      }
    }
  }
#endif
