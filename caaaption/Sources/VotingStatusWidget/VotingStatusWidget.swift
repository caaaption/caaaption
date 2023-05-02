import Dependencies
import SnapshotClient
import SnapshotModel
import SwiftUI
import WidgetKit
import WidgetProtocol

public struct VotingStatusWidget: WidgetProtocol {
  public struct Entrypoint: Widget {
    let kind = Constant.kind
    public init() {}

    public var body: some WidgetConfiguration {
      StaticConfiguration(kind: kind, provider: Provider()) { entry in
        VotingStatusWidget.WidgetView(entry: entry)
      }
      .configurationDisplayName(Constant.displayName)
      .description(Constant.description)
      .supportedFamilies(Constant.supportedFamilies)
    }
  }

  public enum Constant: WidgetConstant {
    public static var displayName = "Voting Status Widget"
    public static var description = "Displays the voting results for the specified Snapshot."
    public static var kind = "VotingStatusWidget"
    public static var supportedFamilies: [WidgetFamily] = [
      .systemSmall,
      .systemMedium,
      .systemLarge,
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
    public let proposal: SnapshotModel.ProposalQuery.Data.Proposal?

    public init(date: Date, proposal: SnapshotModel.ProposalQuery.Data.Proposal?) {
      self.date = date
      self.proposal = proposal
    }
  }

  public struct Provider: TimelineProvider {
    @Dependency(\.snapshotClient) var snapshotClient

    public func placeholder(
      in context: Context
    ) -> Entry {
      Entry(date: Date(), proposal: nil)
    }

    public func getSnapshot(
      in context: Context,
      completion: @escaping (Entry) -> Void
    ) {
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
    public var entry: Entry

    public init(entry: Entry) {
      self.entry = entry
    }

    func percentages(scores: [Double?]?) -> [Double] {
      guard let scores = scores else { return [] }
      let values = scores.map { $0 ?? 0.0 }
      let total = values.reduce(0, +)
      let percentages = values.map { $0 / total }
      return percentages
    }

    func roundConvertToPercentage(_ value: Double) -> String {
      let rounded = (value * 100).rounded()
      return String(format: "%.0f%%", rounded)
    }

    public var body: some View {
      switch entry.proposal {
      case .none:
        ProgressView()
      case let .some(proposal):
        VStack(alignment: .leading, spacing: 8) {
          Text(proposal.title)
            .bold()

          VStack(alignment: .leading, spacing: 2) {
            ForEach(proposal.choices.indices) { index in
              VStack(alignment: .leading, spacing: 0) {
                Text(
                  "\(proposal.choices[index] ?? "") \(roundConvertToPercentage(percentages(scores: proposal.scores)[index]))"
                )
                .foregroundColor(.green)
                .bold()

                ProgressBar(
                  progress: percentages(scores: proposal.scores)[index],
                  primaryColor: .green
                )
              }
            }
          }
          .font(.caption)

          updatedAt
            .foregroundColor(.secondary)
            .font(.caption)
        }
        .padding(.all, 12)
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
