import SwiftUI

public struct PlaceholderAsyncImage: View {
  let url: URL?
  let scale: CGFloat

  public init(
    url: URL?,
    scale: CGFloat = 1
  ) {
    self.url = url
    self.scale = scale
  }

  public var body: some View {
    AsyncImage(
      url: url,
      scale: scale,
      content: { image in
        image.resizable().aspectRatio(contentMode: .fill)
      },
      placeholder: {
        ProgressView()
      }
    )
  }
}
