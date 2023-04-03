@testable import ColorHex
import SwiftUI
import XCTest

class ColorHexTests: XCTestCase {
  func test_black() {
    XCTAssertEqual(
      Color(0x000000),
      Color(.sRGB, red: 0, green: 0, blue: 0, opacity: 1.0)
    )
  }

  func test_white() {
    XCTAssertEqual(
      Color(0xFFFFFF),
      Color(.sRGB, red: 1, green: 1, blue: 1, opacity: 1.0)
    )
  }
}
