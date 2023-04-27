import Foundation
import WidgetKit

public extension WidgetFamily {
  var size: CGSize {
    switch self {
    case .systemSmall:
      return CGSize(width: 158, height: 158)
    case .systemMedium:
      return CGSize(width: 338, height: 158)
    case .systemLarge:
      return CGSize(width: 338, height: 338)
    default:
      return CGSize.zero
    }
  }
}

extension WidgetFamily: Identifiable {
  public var id: Int { rawValue }
}
