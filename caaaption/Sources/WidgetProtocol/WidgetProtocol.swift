import SwiftUI
import WidgetKit

public protocol WidgetProtocol {
  associatedtype Constant: WidgetConstant
  associatedtype Entry: TimelineEntry
  associatedtype Provider: TimelineProvider
  associatedtype Body: View
  associatedtype Entrypoint: Widget
}
