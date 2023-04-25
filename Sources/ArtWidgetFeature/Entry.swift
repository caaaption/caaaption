import WidgetKit
import SwiftUI

public struct Entry: TimelineEntry {
  public let date: Date
  public let url: String
  
  public init(date: Date, url: String) {
    self.date = date
    self.url = url
  }

  func image() -> UIImage {
    guard
      let imageUrl = URL(string: self.url),
      let data = try? Data(contentsOf: imageUrl),
      let image = UIImage(data: data)
    else {
      return UIImage()
    }
    return image
  }
}
