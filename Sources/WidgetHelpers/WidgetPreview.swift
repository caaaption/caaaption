import SwiftUI
import WidgetKit

public struct WidgetPreview<Content: View>: View {
  let families: [WidgetFamily]
  let content: Content

  public init(
    _ families: [WidgetFamily] = [.systemSmall, .systemMedium, .systemLarge],
    @ViewBuilder _ content: () -> Content
  ) {
    self.families = families
    self.content = content()
  }

  public var body: some View {
    Group {
      ForEach(families) { family in
        content
          .previewLayout(
            PreviewLayout.fixed(
              width: family.size.width,
              height: family.size.height
            )
          )
          .environment(\.colorScheme, .light)
          .preferredColorScheme(.light)
      }

      ForEach(families) { family in
        content
          .previewLayout(
            PreviewLayout.fixed(
              width: family.size.width,
              height: family.size.height
            )
          )
          .environment(\.colorScheme, .dark)
          .preferredColorScheme(.dark)
      }
    }
  }
}
