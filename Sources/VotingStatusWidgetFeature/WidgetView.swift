import SwiftUI
import WidgetKit

public struct VotingStatusWidgetView: View {
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

#if DEBUG
  import ApolloTestSupport
  import SnapshotModel
  import SnapshotModelMock
  import WidgetHelpers

  struct VotingStatusWidgetViewPreviews: PreviewProvider {
    static var previews: some View {
      WidgetPreview([.systemMedium]) {
        VotingStatusWidgetView(
          entry: Entry(
            date: Date(),
            proposal: SnapshotModel.ProposalQuery.Data.Proposal.from(
              Mock<Proposal>()
            )
          )
        )
      }
    }
  }
#endif
