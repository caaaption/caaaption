import SwiftUI
import PlaceholderAsyncImage

public struct SpaceCard: View {
  let name: String
  let followersCount: Int

  public var body: some View {
    VStack(spacing: 12) {
      HStack(spacing: 12) {
        PlaceholderAsyncImage(
          url: URL(string: "https://cdn.stamp.fyi/space/\(name)")
        )
        .frame(width: 62, height: 62)
        .clipShape(Circle())

        VStack(alignment: .leading, spacing: 0) {
          Text(name)
            .bold()
          Text("\(followersCount) members")
            .foregroundColor(.secondary)
        }
      }
    }
  }
}

#if DEBUG
struct SpaceCardPreviews: PreviewProvider {
  static var previews: some View {
    SpaceCard(
      name: "Uniswap",
      followersCount: 9200
    )
    .previewLayout(.sizeThatFits)
  }
}
#endif
