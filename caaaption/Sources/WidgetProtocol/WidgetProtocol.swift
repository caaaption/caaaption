import SwiftUI
import WidgetKit

public protocol WidgetProtocol {
  associatedtype Entrypoint: Widget
  associatedtype Constant: WidgetConstant
  associatedtype Input: Codable
  associatedtype Entry: TimelineEntry & Equatable
  associatedtype Provider: TimelineProvider
  associatedtype WidgetView: View
}
