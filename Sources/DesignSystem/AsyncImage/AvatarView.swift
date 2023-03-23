import SwiftUI

public struct AvatarView: View {
  public enum Size: CGFloat, Equatable, CaseIterable {
    case small = 24
    case medium = 36
    case large = 56
  }
  let size: Size
  let avatarUrlString: String
  
  public init(size: Size, avatarUrlString: String) {
    self.size = size
    self.avatarUrlString = avatarUrlString
  }
  
  public var body: some View {
    ProgressAsyncImage(
      imageUrlString: avatarUrlString,
      width: size.rawValue,
      height: size.rawValue,
      radius: size.rawValue / 2
    )
  }
}

private let testAvatarImageUrlString = "https://pbs.twimg.com/profile_images/1528599200132259841/G1fUHZQ9_400x400.jpg"

struct AvatarViewPreview: PreviewProvider {
  static var previews: some View {
    Group {
      ForEach([testAvatarImageUrlString, ""], id: \.self) { avatarUrlString in
        ForEach(AvatarView.Size.allCases, id: \.self) { size in
          AvatarView(size: size, avatarUrlString: avatarUrlString)
            .previewLayout(.sizeThatFits)
            .previewDisplayName("\(size)")
        }
      }
    }
  }
}
