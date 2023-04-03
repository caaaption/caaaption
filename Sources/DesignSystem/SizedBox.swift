import SwiftUI

public struct SizedBox: View {
  let minLength: CGFloat?
  let width: CGFloat?
  let height: CGFloat?

  public init(
    minLength: CGFloat? = nil,
    width: CGFloat? = nil,
    height: CGFloat? = nil
  ) {
    self.minLength = minLength
    self.width = width
    self.height = height
  }

  public var body: some View {
    Spacer(minLength: minLength)
      .frame(width: width, height: height)
  }
}
