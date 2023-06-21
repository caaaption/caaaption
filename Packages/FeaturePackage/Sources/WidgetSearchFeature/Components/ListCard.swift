import SwiftUI
import WidgetProtocol

public struct ListCard<W: WidgetProtocol>: View {
  public init(_ value: W.Type) {}
  public var body: some View {
    VStack(alignment: .leading, spacing: 0) {
      Text(W.Constant.displayName)
        .foregroundColor(.primary)
      Text(W.Constant.description)
        .foregroundColor(.secondary)
    }
  }
}
