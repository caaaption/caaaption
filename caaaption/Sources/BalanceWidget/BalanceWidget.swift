import Dependencies
import QuickNodeClient
import SwiftUI
import UserDefaultsClient
import WidgetKit
import WidgetProtocol

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
    public let address: String
    public let balance: Decimal

    public init(
      date: Date,
      address: String,
      balance: Decimal
    ) {
      self.date = date
      self.address = address
      self.balance = balance
    }
  }

  public struct Provider: TimelineProvider {
    @Dependency(\.quickNodeClient) var quickNodeClient
    @Dependency(\.userDefaults) var userDefaults

    public func placeholder(
      in context: Context
    ) -> Entry {
      Entry(date: Date(), address: "placeholder", balance: 11.0)
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
        let entry = Entry(date: Date(), address: input.address, balance: balance)
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

        Text(entry.address)
          .foregroundColor(.secondary)
          .font(.caption)

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

#if DEBUG
  import WidgetHelpers

  struct WidgetViewPreviews: PreviewProvider {
    static var previews: some View {
      WidgetPreview([.systemSmall]) {
        BalanceWidget.WidgetView(
          entry: BalanceWidget.Entry(
            date: Date(),
            address: "tomokisun.eth",
            balance: 11.0
          )
        )
      }
    }
  }
#endif
