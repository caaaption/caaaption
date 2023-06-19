import SwiftUI

struct ScoreProgress: View {
  let progress: Double

  init(progress: Double) {
    self.progress = progress
  }

  var body: some View {
    GeometryReader { proxy in
      ZStack {
        Path { path in
          path.move(to: CGPoint(x: 4, y: proxy.size.height - 4))
          path.addQuadCurve(
            to: CGPoint(x: proxy.size.width - 4, y: proxy.size.height - 4),
            control: CGPoint(x: proxy.size.width / 2, y: -20)
          )
        }
        .stroke(
          Color(.secondarySystemFill),
          style: StrokeStyle(
            lineWidth: 8,
            lineCap: .round,
            lineJoin: .round
          )
        )

        Path { path in
          path.move(to: CGPoint(x: 4, y: proxy.size.height - 4))
          path.addQuadCurve(
            to: CGPoint(x: proxy.size.width - 4, y: proxy.size.height - 4),
            control: CGPoint(x: proxy.size.width / 2, y: -20)
          )
        }
        .trim(from: 0.0, to: min(progress, 1.0))
        .stroke(
          Color("progress", bundle: .module),
          style: StrokeStyle(
            lineWidth: 8,
            lineCap: .round,
            lineJoin: .round
          )
        )
      }
    }
  }
}

struct ScoreProgressPreviews: PreviewProvider {
  static var previews: some View {
    ScoreProgress(progress: 0.8)
      .frame(width: 150, height: 34)
      .previewLayout(.sizeThatFits)
  }
}
