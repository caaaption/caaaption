import SwiftUI
import WidgetProtocol

public struct ListCard<W: WidgetProtocol>: View {
  public init(_ value: W.Type) {}
  public var body: some View {
    VStack(spacing: 12) {
      HStack(spacing: 12) {
        Color.red
          .frame(width: 62, height: 62)
          .cornerRadius(12)

        VStack(alignment: .leading, spacing: 0) {
          Text(W.Constant.displayName)
            .bold()
          Text(W.Constant.description)
            .foregroundColor(.secondary)
        }
      }
    }
  }
}
