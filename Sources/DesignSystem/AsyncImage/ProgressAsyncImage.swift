import SwiftUI

public struct ProgressAsyncImage: View {
  let imageUrlString: String
  let width: CGFloat?
  let height: CGFloat?
  let radius: CGFloat
  
  public init(
    imageUrlString: String,
    width: CGFloat? = nil,
    height: CGFloat? = nil,
    radius: CGFloat = 0
  ) {
    self.imageUrlString = imageUrlString
    self.width = width
    self.height = height
    self.radius = radius
  }
  
  public var body: some View {
    AsyncImage(
      url: URL(string: imageUrlString),
      content: { image in
        image
          .resizable()
          .aspectRatio(contentMode: .fill)
          .frame(width: width, height: height)
          .cornerRadius(radius)
      },
      placeholder: {
        ProgressView()
      }
    )
  }
}
