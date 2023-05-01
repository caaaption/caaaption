import SwiftUI
import WidgetKit

public protocol WidgetProtocol {
  associatedtype Entrypoint: Widget
  associatedtype Constant: WidgetConstant
  associatedtype Entry: TimelineEntry
  associatedtype Provider: TimelineProvider
  associatedtype WidgetView: View
}
