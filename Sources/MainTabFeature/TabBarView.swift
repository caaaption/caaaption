import SwiftUI

public struct TabBarView: View {
  let actionFeed: () -> Void
  let actionUpload: () -> Void
  let actionMypage: () -> Void
  
  public init(
    actionFeed: @escaping () -> Void,
    actionUpload: @escaping () -> Void,
    actionMypage: @escaping () -> Void
  ) {
    self.actionFeed = actionFeed
    self.actionUpload = actionUpload
    self.actionMypage = actionMypage
  }
  
  public var body: some View {
    VStack {
      Color(uiColor: .separator)
        .frame(height: 0.3)
      
      HStack(spacing: 12) {
        Button(action: actionFeed) {
          Color.green
            .opacity(0.2)
            .cornerRadius(6)
            .frame(width: 56, height: 48)
        }
        
        Button(action: actionUpload) {
          Color.green
            .cornerRadius(6)
            .frame(height: 48)
            .frame(maxWidth: .infinity)
        }
        
        Button(action: actionMypage) {
          Color(uiColor: .systemGray6)
            .cornerRadius(6)
            .frame(width: 56, height: 48)
        }
      }
      .padding(.horizontal, 24)
      .padding(.top, 16)
      .padding(.bottom, 40)
    }
  }
}

struct TabBarViewPreview: PreviewProvider {
  static var previews: some View {
    TabBarView(
      actionFeed: {},
      actionUpload: {},
      actionMypage: {}
    )
    .previewLayout(.sizeThatFits)
  }
}
