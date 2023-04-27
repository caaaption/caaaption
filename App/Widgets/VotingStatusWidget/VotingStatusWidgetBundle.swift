import Dependencies
import SnapshotClient
import SwiftUI
import VotingStatusWidgetFeature
import WidgetKit

@main
struct VotingStatusWidgetBundle: WidgetBundle {
  var body: some Widget {
    withDependencies {
      $0.snapshotClient = .liveValue
    } operation: {
      VotingStatusWidget()
    }
  }
}
