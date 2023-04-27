import WidgetKit

public struct Entry: TimelineEntry {
  public let date: Date

  public init(date: Date) {
    self.date = date
  }
}
