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
    public let title: String
    public let score: Double
    public let choice: String

    public init(date: Date, title: String, score: Double, choice: String) {
      self.date = date
      self.title = title
      self.score = score
      self.choice = choice
    }
  }

  public struct Provider: TimelineProvider {
    @Dependency(\.userDefaults) var userDefaults
    @Dependency(\.snapshotClient) var snapshotClient

    public func placeholder(
      in context: Context
    ) -> Entry {
      Entry(
        date: Date(),
        title: "System Upgrade: Establishing A Software Company",
        score: 0.8599,
        choice: "Yes - Approve this Plan"
      )
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
        do {
          let result = try await snapshotClient.proposal(input.proposalId)
          guard
            let proposal = result.data?.proposal
          else {
            return completion(placeholder(in: context))
          }
          
          let scores = (proposal.scores ?? []).map { $0 ?? 0.0 }
          let choices = proposal.choices.map { $0 ?? "" }
          let values = Array(zip(scores, choices))
          let totalScore = scores.reduce(0, +)
          let sorted = values.sorted(by: { $0.0 > $1.0 })
          let percentages: [(Double, String)] = sorted.map { (score, choice) in
            return (score / totalScore, choice)
          }

          let entry = Entry(
            date: Date(),
            title: proposal.title,
            score: percentages.first?.0 ?? 0.0,
            choice: percentages.first?.1 ?? ""
          )
          completion(entry)
        } catch {
          completion(placeholder(in: context))
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
      VStack(alignment: .center, spacing: 4) {
        HStack(alignment: .top) {
          Text(entry.title)
            .font(.caption2)
            .multilineTextAlignment(.leading)
            .frame(maxWidth: .infinity)

          Color.red
            .frame(width: 24, height: 24)
            .clipShape(Circle())
        }

        VStack(spacing: 0) {
          ZStack(alignment: .bottom) {
            ScoreProgress(progress: entry.score)
              .frame(height: 34)
              .padding(.bottom, 50 - 34)
            
            Text(String(format: "%.2f%%", entry.score * 100))
              .font(.title2)
              .bold()
          }
          .frame(height: 50)

          Text(entry.choice)
            .lineLimit(1)
            .font(.caption2)
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
      WidgetPreview([.systemSmall]) {
        VoteWidget.WidgetView(
          entry: VoteWidget.Entry(
            date: Date(),
            title: "System Upgrade: Establishing A Software Company",
            score: 0.8599,
            choice: "Yes - Approve this Plan"
          )
        )
      }
    }
  }
#endif
