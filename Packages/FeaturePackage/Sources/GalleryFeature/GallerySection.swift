import SwiftUI

struct GallerySection<Content: View>: View {
  let title: LocalizedStringKey
  let description: LocalizedStringKey
  let action: () -> Void
  let content: () -> Content

  init(
    title: LocalizedStringKey,
    description: LocalizedStringKey,
    action: @escaping () -> Void,
    @ViewBuilder content: @escaping () -> Content
  ) {
    self.title = title
    self.description = description
    self.action = action
    self.content = content
  }

  var body: some View {
    VStack(spacing: 16) {
      HStack(alignment: .top) {
        VStack(alignment: .leading, spacing: 4) {
          Text(title)
            .font(.title3)
            .bold()
          Text(description)
            .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)

        Button("See All", action: action)
      }
      .padding(.horizontal, 16)

      ScrollView(.horizontal, showsIndicators: false) {
        LazyHStack {
          content()
        }
        .padding(.horizontal, 16)
      }
    }
  }
}

#if DEBUG
  struct GallerySectionPreviews: PreviewProvider {
    static var previews: some View {
      GallerySection(
        title: "Get Stuff Done",
        description: "Shortcuts to help you focus",
        action: {}
      ) {
        Text("Content")
      }
      .frame(width: 375)
      .previewLayout(.sizeThatFits)
    }
  }
#endif
