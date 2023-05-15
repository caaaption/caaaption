import BalanceWidget
import Dependencies
import QuickNodeClient
import SnapshotClient
import SwiftUI
import UserDefaultsClient
import VoteWidget
import WidgetKit

@main
struct WidgetExtensionBundle: WidgetBundle {
  var body: some Widget {
    withDependencies {
      $0.userDefaults = .liveValue
      $0.quickNodeClient = .liveValue
    } operation: {
      BalanceWidget.Entrypoint()
    }

    withDependencies {
      $0.snapshotClient = .liveValue
    } operation: {
      VoteWidget.Entrypoint()
    }
  }
}
