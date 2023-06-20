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
      StaticConfiguration(
        kind: kind,
        provider: Provider(),
        content: BalanceWidget.WidgetView.init(entry:)
      )
      .configurationDisplayName(Constant.displayName)
      .description(Constant.description)
      .supportedFamilies(Constant.supportedFamilies)
    }
  }

  public enum Constant: WidgetConstant {
    public static var displayName = "Show balance"
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
    @Dependency(\.quickNodeClient.balance) var getBalance
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
        let request = BalanceRequest(address: input.address)
        let balance = try await getBalance(request)
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
      VStack {
        VStack(alignment: .leading, spacing: 4) {
          Text(shortenHex(hexString: entry.address))
            .font(.subheadline)
            .lineLimit(1)
            .frame(maxHeight: .infinity, alignment: .top)

          Text("\(entry.balance.description.prefix(6).lowercased()) ETH")
            .font(.title2)
            .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .padding(.all, 16)
      }
      .background(Color(uiColor: UIColor.tertiarySystemBackground))
      .widgetURL(
        URL(string: "https://etherscan.io/address/\(entry.address)")
      )
    }

    func shortenHex(hexString: String, startLength: Int = 4, endLength: Int = 4) -> String {
      guard hexString.count > (startLength + endLength) else {
        return hexString
      }
      let startIndex = hexString.index(hexString.startIndex, offsetBy: startLength)
      let endIndex = hexString.index(hexString.endIndex, offsetBy: -endLength)

      return "\(hexString[..<startIndex])…\(hexString[endIndex...])"
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
            address: "0x4F724516242829DC5Bc6119f666b18102437De53",
            balance: 0.01
          )
        )
      }
    }
  }
#endif
