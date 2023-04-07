import SwiftUI

public struct OffsetObservingScrollView<Content: View>: View {
  let axes: Axis.Set
  var showsIndicators: Bool
  @Binding var offset: CGPoint
  @ViewBuilder var content: () -> Content
  
  private let coordinateSpaceName = UUID()
  
  public init(
    _ axes: Axis.Set = .vertical,
    showsIndicators: Bool = true,
    offset: Binding<CGPoint>,
    @ViewBuilder content: @escaping () -> Content
  ) {
    self.axes = axes
    self.showsIndicators = showsIndicators
    self._offset = offset
    self.content = content
  }
  
  public var body: some View {
    ScrollView(axes, showsIndicators: showsIndicators) {
      PositionObservingView(
        coordinateSpace: .named(coordinateSpaceName),
        position: Binding(
          get: { offset },
          set: { newOffset in
            offset = CGPoint(
              x: -newOffset.x,
              y: -newOffset.y
            )
          }
        ),
        content: content
      )
    }
    .coordinateSpace(name: coordinateSpaceName)
  }
}
