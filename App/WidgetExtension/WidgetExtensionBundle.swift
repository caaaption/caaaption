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
      $0.quickNodeClient = .liveValue
      $0.userDefaults = .live(
        suiteName: Bundle.main.object(forInfoDictionaryKey: "AppGroup") as! String
      )
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
