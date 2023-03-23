import UIKit
import Dependencies

extension FeedbackGeneratorClient: DependencyKey {
  public static let liveValue = {
    let selection = UISelectionFeedbackGenerator()
    let impact = UIImpactFeedbackGenerator()
    return Self(
      selectionChanged: { await selection.selectionChanged() },
      impactOccurred: { await impact.impactOccurred() }
    )
  }()
}

extension DependencyValues {
  public var feedbackGenerator: FeedbackGeneratorClient {
    get { self[FeedbackGeneratorClient.self] }
    set { self[FeedbackGeneratorClient.self] = newValue }
  }
}
