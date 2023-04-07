import SwiftUI

public struct StatusLabel: View {
  public enum Status: Equatable {
    case available(LocalizedStringKey)
    case unavailable(LocalizedStringKey)
  }

  let localizedKey: LocalizedStringKey
  let foregroundColor: Color
  let backgroundColor: Color

  public init(
    status: Status
  ) {
    switch status {
    case let .available(value):
      localizedKey = value
      foregroundColor = Color.green
      backgroundColor = Color.green.opacity(0.2)
    case let .unavailable(value):
      localizedKey = value
      foregroundColor = Color.red
      backgroundColor = Color.red.opacity(0.2)
    }
  }

  public var body: some View {
    Text(localizedKey)
      .font(.headline)
      .frame(height: 32)
      .foregroundColor(foregroundColor)
      .background(backgroundColor)
      .cornerRadius(32 / 2)
  }
}

struct StatusLabelPreview: PreviewProvider {
  static var previews: some View {
    Group {
      StatusLabel(
        status: StatusLabel.Status.available(
          "That username is avaliable!"
        )
      )
      StatusLabel(
        status: StatusLabel.Status.unavailable(
          "Tha username is unavaliable!"
        )
      )
    }
  }
}
