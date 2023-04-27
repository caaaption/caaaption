import WidgetKit
import Apollo
import SnapshotModel

public struct Entry: TimelineEntry {
  public let date: Date
  public let proposal: SnapshotModel.ProposalQuery.Data.Proposal?

  public init(date: Date, proposal: SnapshotModel.ProposalQuery.Data.Proposal?) {
    self.date = date
    self.proposal = proposal
  }
}
