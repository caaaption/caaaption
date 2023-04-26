import SwiftUI
import WidgetKit

public struct Entry: TimelineEntry {
  public let date: Date
  public let balance: Double

  public init(date: Date, balance: Double) {
    self.date = date
    self.balance = balance
  }
}
