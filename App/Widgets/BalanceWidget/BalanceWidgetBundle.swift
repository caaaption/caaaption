import BalanceWidget
import Dependencies
import QuickNodeClient
import SwiftUI
import UserDefaultsClient
import WidgetKit

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
