import SwiftUI
import SnapshotModel
import VotingStatusWidget

struct ProposalCard: View {
  let proposal: SnapshotModel.ProposalsQuery.Data.Proposal
  
  var body: some View {
    VStack(alignment: .leading, spacing: 8) {
      Text(proposal.title)
        .bold()
      
      if let body = proposal.body {
        Text(
          body
            .replacing("\n", with: "")
            .replacing("# ", with: "")
            .replacing("#", with: "")
        )
        .lineLimit(2)
      }
      
      Divider()
      
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
      
      Divider()
      
      HStack {
        Text(Date.init(timeIntervalSince1970: .init(proposal.created)), format: .relative(presentation: .numeric))
          .foregroundColor(.secondary)
        Spacer()
        if let state = proposal.state {
          Text(state)
            .foregroundColor(Color.white)
            .bold()
            .padding()
            .frame(height: 32)
            .background(Color.purple)
            .clipShape(Capsule())
        }
      }
    }
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
}

#if DEBUG
struct ProposalCardPreviews: PreviewProvider {
  static var previews: some View {
    ProposalCard(
      proposal: .init(
        _dataDict: DataDict(
          data: [
            "id": "0x73021d63f985aba8e42c67165f80c0027a591980a5cc372cda9637bdf2173f95",
            "created": 1682456523,
            "ipfs": "bafkreifnfy5wira2y3744irddpz6x5ea7azoef2vhsjj77lcxou7oom3ei",
            "title": "[Temperature Check] Deploy Uniswap v3 on Moonbeam (2023)",
            "body": "## Proposal Motivation\n\nWe Michigan Blockchain are submitting this proposal to reinstate the deployment of Uniswap v3 on Polkadot’s EVM-compatible parachain, Moonbeam.",
            "choices": [
              "Yes",
              "No",
              "Abstain"
            ],
            "scores": [
              80,
              15,
              5
            ],
            "state": "closed"
          ]
        )
      )
    )
    .previewLayout(.sizeThatFits)
  }
}
#endif
