import SwiftUI

public struct InstallButton: View {
  let action: () -> Void

  public init(action: @escaping () -> Void) {
    self.action = action
  }

  public var body: some View {
    Button("Install", action: action)
      .foregroundColor(.blue)
      .bold()
  }
}
