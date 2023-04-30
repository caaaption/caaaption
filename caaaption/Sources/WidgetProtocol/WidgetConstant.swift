import WidgetKit

public protocol WidgetConstant {
  static var displayName: String { get }
  static var description: String { get }
  static var kind: String { get }
  static var supportedFamilies: [WidgetFamily] { get }
}
