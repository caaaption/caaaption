import WidgetKit
import SwiftUI
import VoteWidget

@main
struct VoteWidgetBundle: WidgetBundle {
  var body: some Widget {
    VoteWidget.Entrypoint()
  }
}
