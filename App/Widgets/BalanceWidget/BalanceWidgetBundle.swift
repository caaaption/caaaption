import BalanceWidget
import SwiftUI
import WidgetKit
import Dependencies
import QuickNodeClient
import UserDefaultsClient

@main
struct BalanceWidgetBundle: WidgetBundle {
  var body: some Widget {
    withDependencies {
      $0.userDefaults = .liveValue
      $0.quickNodeClient = .liveValue
    } operation: {
      BalanceWidget.Entrypoint()
    }
  }
}
