import WidgetKit
import SwiftUI

public struct ArtWidgetEntry: TimelineEntry {
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

public struct ArtWidgetView: View {
  public var entry: ArtWidgetEntry
  
  public init(entry: ArtWidgetEntry) {
    self.entry = entry
  }
  
  public var body: some View {
    Image(uiImage: entry.image())
      .resizable()
                  .aspectRatio(contentMode: .fill)
  }
}
