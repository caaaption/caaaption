import SwiftUI

public struct PlaceholderAsyncImage: View {
  let url: URL?
  let scale: CGFloat
  let width: CGFloat?
  let height: CGFloat?
  let radius: CGFloat
  
  public init(
    url: URL?,
    scale: CGFloat = 1,
    width: CGFloat? = nil,
    height: CGFloat? = nil,
    radius: CGFloat = 0
  ) {
    self.url = url
    self.scale = scale
    self.width = width
    self.height = height
    self.radius = radius
  }
  
  public var body: some View {
    AsyncImage(
      url: url,
      scale: scale,
      content: { image in
        image
          .resizable()
          .aspectRatio(contentMode: .fill)
          .frame(width: width, height: height)
          .cornerRadius(radius)
      },
      placeholder: {
        ProgressView()
          .frame(width: width, height: height)
      }
    )
  }
}
