import Dependencies
import SnapshotClient
import SwiftUI
import VotingStatusWidget
import WidgetKit

@main
struct VotingStatusWidgetBundle: WidgetBundle {
  var body: some Widget {
    withDependencies {
      $0.snapshotClient = .liveValue
    } operation: {
      VotingStatusWidget.Entrypoint()
    }
  }
}
