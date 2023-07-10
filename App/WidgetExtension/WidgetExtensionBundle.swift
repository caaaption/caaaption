import BalanceWidget
import Dependencies
import POAPWidget
import SwiftUI
import VoteWidget
import WidgetKit

@main
struct WidgetExtensionBundle: WidgetBundle {
  var body: some Widget {
    BalanceWidget.Entrypoint()
    VoteWidget.Entrypoint()
    POAPWidget.Entrypoint()
  }
}
