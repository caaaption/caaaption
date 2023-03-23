import SwiftUI
import DesignSystem

struct PostHeaderView: View {
  let avatarUrlString: String
  
  var body: some View {
    HStack {
      AvatarView(
        size: .medium,
        avatarUrlString: avatarUrlString
      )
      Spacer()
    }
  }
}
