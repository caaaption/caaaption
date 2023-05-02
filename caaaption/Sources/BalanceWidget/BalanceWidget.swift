import SwiftUI
import WidgetKit
import WidgetProtocol
import Dependencies
import QuickNodeClient
import UserDefaultsClient

public struct BalanceWidget: WidgetProtocol {
  public struct Entrypoint: Widget {
    let kind = Constant.kind
    public init() {}

    public var body: some WidgetConfiguration {
      StaticConfiguration(kind: kind, provider: Provider()) { entry in
        BalanceWidget.WidgetView(entry: entry)
      }
      .configurationDisplayName(Constant.displayName)
      .description(Constant.description)
      .supportedFamilies(Constant.supportedFamilies)
    }
  }

  public enum Constant: WidgetConstant {
    public static var displayName = "Balance Widget"
    public static var description = "Displays wallet balance."
    public static var kind = "BalanceWidget"
    public static var supportedFamilies: [WidgetFamily] = [
      .systemSmall,
    ]
  }
  
  public struct Input: Codable {
    public let address: String
    
    public init(address: String) {
      self.address = address
    }
  }

  public struct Entry: TimelineEntry, Equatable {
    public let date: Date
    public let balance: Decimal

    public init(date: Date, balance: Decimal) {
      self.date = date
      self.balance = balance
    }
  }

  public struct Provider: TimelineProvider {
    @Dependency(\.quickNodeClient) var quickNodeClient
    @Dependency(\.userDefaults) var userDefaults
    
    public func placeholder(
      in context: Context
    ) -> Entry {
      Entry(date: Date(), balance: 1.0)
    }

    public func getSnapshot(
      in context: Context,
      completion: @escaping (Entry) -> Void
    ) {
      guard
        let input = try? userDefaults.codableForKey(Input.self, forKey: Constant.kind)
      else {
        completion(
          placeholder(in: context)
        )
        return
      }
      
      Task {
        let balance = try await quickNodeClient.getBalance(input.address)
        let entry = Entry(date: Date(), balance: balance)
        completion(entry)
      }
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

  public struct WidgetView: View {
    let entry: Entry

    public init(entry: Entry) {
      self.entry = entry
    }

    public var body: some View {
      VStack(spacing: 8) {
        Spacer()
        Text("Balance")
          .font(Font.headline)

        Text("\(entry.balance.description.prefix(6).lowercased()) ETH")
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
