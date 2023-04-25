import SwiftUI
import WidgetKit

public struct WidgetView: View {
  public var entry: Entry

  public init(entry: Entry) {
    self.entry = entry
  }

  public var body: some View {
    Image(uiImage: entry.image())
      .resizable()
      .aspectRatio(contentMode: .fill)
  }
}

struct WidgetViewPreviews: PreviewProvider {
  static var previews: some View {
    WidgetView(entry: Entry(date: Date(), url: imageUrl))
      .previewContext(WidgetPreviewContext(family: .systemSmall))
  }
}
