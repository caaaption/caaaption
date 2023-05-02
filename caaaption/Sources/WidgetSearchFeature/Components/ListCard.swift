import SwiftUI

public struct ListCard: View {
  let displayName: String
  let description: String
  
  init(
    displayName: String,
    description: String
  ) {
    self.displayName = displayName
    self.description = description
  }
  
  public var body: some View {
    VStack(spacing: 12) {
      HStack(spacing: 12) {
        Color.red
          .frame(width: 62, height: 62)
          .cornerRadius(12)

        VStack(alignment: .leading, spacing: 0) {
          Text(displayName)
            .bold()
          Text(description)
            .foregroundColor(.secondary)
        }

        Spacer()

        InstallButton(action: {})
      }
    }
  }
}
