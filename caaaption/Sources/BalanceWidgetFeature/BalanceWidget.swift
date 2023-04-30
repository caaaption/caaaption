import WidgetProtocol
import WidgetKit
import SwiftUI

public struct BalanceWidget: WidgetProtocol {
  public struct Entrypoint: Widget {
    let kind: String = "BalanceWidget"
    public init() {}
    
    public var body: some WidgetConfiguration {
      StaticConfiguration(kind: kind, provider: Provider()) { entry in
        BalanceWidget.Body(entry: entry)
      }
      .configurationDisplayName("Balance Widget")
      .description("Displays wallet balance.")
      .supportedFamilies([.systemSmall])
    }
  }
  
  public enum Constant: WidgetConstant {
    public static var displayName = "Balance Widget"
    public static var description = "Displays wallet balance."
    public static var kind = "BalanceWidget"
    public static var supportedFamilies: [WidgetFamily] = [
      .systemSmall
    ]
  }
  
  public struct Entry: TimelineEntry {
    public let date: Date
    public let balance: Double

    public init(date: Date, balance: Double) {
      self.date = date
      self.balance = balance
    }
  }
  
  public struct Provider: TimelineProvider {
    public func placeholder(
      in context: Context
    ) -> Entry {
      Entry(date: Date(), balance: 1.0)
    }

    public func getSnapshot(
      in context: Context,
      completion: @escaping (Entry) -> Void
    ) {
      let entry = Entry(date: Date(), balance: 1.0)
      completion(entry)
    }

    public func getTimeline(
      in context: Context,
      completion: @escaping (Timeline<Entry>) -> Void
    ) {
      getSnapshot(in: context) { entry in
        let timeline = Timeline(entries: [entry], policy: .atEnd)
        completion(timeline)
      }
    }
  }
  
  public struct Body: View {
    let entry: Entry
    
    public init(entry: Entry) {
      self.entry = entry
    }
    
    public var body: some View {
      VStack(spacing: 8) {
        Spacer()
        Text("Balance")
          .font(Font.headline)

        Text("\(entry.balance.description) ETH")
          .font(Font.title2)
          .bold()
          .foregroundColor(Color.blue)

        Spacer()

        updatedAt
          .foregroundColor(Color.secondary)
          .font(Font.caption)
      }
      .frame(maxWidth: CGFloat.infinity, maxHeight: CGFloat.infinity)
      .padding()
    }

    var updatedAt: some View {
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = "HH:mm"
      let dateString = dateFormatter.string(from: entry.date)
      return Text("Updated at \(dateString)")
    }
  }
}
