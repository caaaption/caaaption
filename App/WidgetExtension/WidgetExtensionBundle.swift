import BalanceWidget
import Dependencies
import MirrorWidget
import POAPWidget
import QuickNodeClient
import SnapshotClient
import SnapshotSpaceWidget
import SwiftUI
import UserDefaultsClient
import VoteWidget
import WidgetKit

@main
struct WidgetExtensionBundle: WidgetBundle {
  var body: some Widget {
    withDependencies {
      $0.quickNodeClient = .liveValue
      $0.userDefaults = .liveValue
    } operation: {
      BalanceWidget.Entrypoint()
    }

    withDependencies {
      $0.snapshotClient = .liveValue
      $0.userDefaults = .liveValue
    } operation: {
      VoteWidget.Entrypoint()
    }

    withDependencies {
      $0.userDefaults = .liveValue
    } operation: {
      POAPWidget.Entrypoint()
    }
  }
}
