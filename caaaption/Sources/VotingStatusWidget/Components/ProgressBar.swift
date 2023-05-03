import SwiftUI

public struct ProgressBar: View {
  let progress: Double
  let primaryColor: Color
  
  public init(
    progress: Double,
    primaryColor: Color
  ) {
    self.progress = progress
    self.primaryColor = primaryColor
  }

  public var body: some View {
    GeometryReader { proxy in
      ZStack(alignment: .leading) {
        Color.black

        primaryColor
          .cornerRadius(3)
          .frame(width: proxy.size.width * min(progress, 1.0))
      }
    }
    .cornerRadius(3)
    .frame(height: 12)
  }
}

#if DEBUG
struct ProgressBarPreviews: PreviewProvider {
  static var previews: some View {
    VStack(spacing: 12) {
      ProgressBar(progress: 0.0, primaryColor: .green)
      ProgressBar(progress: 0.33, primaryColor: .green)
      ProgressBar(progress: 0.66, primaryColor: .gray)
      ProgressBar(progress: 1.0, primaryColor: .gray)
    }
    .padding()
    .previewLayout(.sizeThatFits)
  }
}
#endif
