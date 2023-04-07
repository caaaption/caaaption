import SwiftUI

public struct PositionObservingView<Content: View>: View {
  var coordinateSpace: CoordinateSpace
  @Binding var position: CGPoint
  @ViewBuilder var content: () -> Content
  
  public var body: some View {
    content()
      .background(
        GeometryReader { proxy in
          Color.clear.preference(
            key: PreferenceKey.self,
            value: proxy.frame(in: coordinateSpace).origin
          )
        }
      )
      .onPreferenceChange(PreferenceKey.self) { position in
        self.position = position
      }
  }
}

private extension PositionObservingView {
  struct PreferenceKey: SwiftUI.PreferenceKey {
    static var defaultValue: CGPoint { .zero }
    
    static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) {
    }
  }
}
