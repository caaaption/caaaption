import SwiftUI

public struct TextButton: View {
  let action: () -> Void
  let titleKey: LocalizedStringKey
  let height: CGFloat = 56
  
  public init(
    _ titleKey: LocalizedStringKey,
    action: @escaping () -> Void
  ) {
    self.titleKey = titleKey
    self.action = action
  }
  
  public var body: some View {
    Button(action: action, label: {
      Text(titleKey)
        .fontWeight(.bold)
        .frame(maxWidth: .infinity, minHeight: height)
        .foregroundColor(Color.white)
        .background(Color.green)
        .cornerRadius(height / 2)
    })
  }
}
