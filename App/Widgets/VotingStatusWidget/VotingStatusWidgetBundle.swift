import SwiftUI
import VotingStatusWidgetFeature
import WidgetKit
import SnapshotClient
import Dependencies

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
