import SwiftUI

public struct CircleGrafValue: Hashable, Identifiable {
  public var id: UUID = .init()
  let startDegrees: Double
  let endDegrees: Double
  let color: Color
}

public struct CircleGraf: View {
  let scores: [Double]
  let colors: [Color] = [
    .blue,
    .green,
    .gray,
    .yellow,
    .red,
    .purple,
    .pink,
    .orange,
    .brown,
    .cyan,
    .indigo,
    .mint,
  ]
  
  func percentages(scores: [Double]) -> [CircleGrafValue] {
    let sortedScores = scores.sorted(by: >)
    let total = sortedScores.reduce(0, +)
    let percentages = sortedScores.map { $0 / total }
    
    var values: [CircleGrafValue] = []
    percentages.enumerated().forEach { index, percentage in
      let startDegrees = values.last?.endDegrees ?? 0
      values.append(
        CircleGrafValue(
          startDegrees: startDegrees,
          endDegrees: startDegrees + 360 * percentage,
          color: colors[index]
        )
      )
    }
    return values
  }
  
  public init(scores: [Double]) {
    self.scores = scores
  }
  
  public var body: some View {
    ZStack {
      ForEach(percentages(scores: scores)) { value in
        GeometryReader { proxy in
          Path { path in
            path.move(to: center(proxy: proxy))
            path.addArc(
              center: center(proxy: proxy),
              radius: 180,
              startAngle: Angle(degrees: value.startDegrees),
              endAngle: Angle(degrees: value.endDegrees),
              clockwise: false
            )
          }
          .fill(value.color)
        }
      }
      .rotationEffect(Angle(degrees: 270.0))
    }
  }
  
  func center(proxy: GeometryProxy) -> CGPoint {
    return CGPoint(
      x: proxy.size.width / 2,
      y: proxy.size.height / 2
    )
  }
}

struct CircleGrafPreviews: PreviewProvider {
  static var previews: some View {
    CircleGraf(
      scores: [10,20,30,40]
    )
    .previewLayout(.sizeThatFits)
  }
}
