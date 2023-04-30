import BalanceWidgetFeature
import SwiftUI
import WidgetKit

@main
struct BalanceWidgetBundle: WidgetBundle {
  var body: some Widget {
    BalanceWidget.Entrypoint()
  }
}
