import SwiftUI

public struct ListCard: View {
  public var body: some View {
    VStack(spacing: 12) {
      HStack(spacing: 12) {
        Color.red
          .frame(width: 62, height: 62)
          .cornerRadius(12)

        VStack(alignment: .leading, spacing: 0) {
          Text("Check your balance")
            .bold()
          Text("QuickNode")
            .foregroundColor(.secondary)
        }

        Spacer()

        InstallButton(action: {})
      }
    }
  }
}
