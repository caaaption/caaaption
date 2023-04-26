import Foundation

public enum PreviewWidgetFamily: Int, CaseIterable, Identifiable {
  case systemSmall
  case systemMedium
  case systemLarge
  
  public var id: Int { rawValue }
  
  public var size: CGSize {
    switch self {
    case .systemSmall:
      return CGSize(width: 158, height: 158)
    case .systemMedium:
      return CGSize(width: 338, height: 158)
    case .systemLarge:
      return CGSize(width: 338, height: 338)
    }
  }
}
