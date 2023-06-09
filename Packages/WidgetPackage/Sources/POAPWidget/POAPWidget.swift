import Dependencies
import Foundation
import POAPClient
import SwiftUI
import UserDefaultsClient
import WidgetKit
import WidgetProtocol

public struct POAPWidget: WidgetProtocol {
  public struct Entrypoint: Widget {
    let kind = Constant.kind
    public init() {}

    public var body: some WidgetConfiguration {
      StaticConfiguration(
        kind: kind,
        provider: Provider(),
        content: POAPWidget.WidgetView.init(entry:)
      )
      .configurationDisplayName(Constant.displayName)
      .description(Constant.description)
      .supportedFamilies(Constant.supportedFamilies)
    }
  }

  public enum Constant: WidgetConstant {
    public static var displayName = "POAP"
    public static var description = "Show POAP"
    public static var kind = "POAPWidget"
    public static var supportedFamilies: [WidgetFamily] = [
      .systemSmall,
      .systemLarge,
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
    public let data: [Data]
    public let address: String

    public init(
      date: Date,
      data: [Data],
      address: String
    ) {
      self.date = date
      self.data = data
      self.address = address
    }
  }

  public struct Provider: TimelineProvider {
    @Dependency(\.poapClient) var poapClient
    @Dependency(\.userDefaults) var userDefaults

    public func placeholder(
      in context: Context
    ) -> Entry {
      Entry(date: Date(), data: [], address: "poap.eth")
    }

    public func getSnapshot(
      in context: Context,
      completion: @escaping (Entry) -> Void
    ) {
      Task {
        guard
          let input = try userDefaults.codableForKey(Input.self, forKey: Constant.kind)
        else {
          completion(placeholder(in: context))
          return
        }
        let request = ScanRequest(address: input.address)
        let response = try await poapClient.scan(request)
        let contents = response.sorted(by: { $0.created > $1.created })
        let imageUrls = contents.count >= 4
          ? contents.prefix(4).map(\.event.imageUrl)
          : contents.map(\.event.imageUrl)
        let data = imageUrls.compactMap { try? Data(contentsOf: $0) }
        let entry = Entry(date: Date(), data: data, address: input.address)
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
        LazyVGrid(
          columns: Array(repeating: GridItem(), count: 2),
          alignment: .center,
          spacing: 6
        ) {
          ForEach(entry.data, id: \.self) { data in
            Image(
              uiImage: UIImage(data: data)!
                .resized(toWidth: 64 * 3)!
            )
            .resizable()
            .scaledToFill()
            .background(Color.red)
            .clipShape(Circle())
            .overlay(
              RoundedRectangle(cornerRadius: 1000)
                .stroke(Color.primary, lineWidth: 1)
            )
            .shadow(
              color: Color("shadow", bundle: .module),
              radius: 0,
              x: -2,
              y: 4
            )
          }
        }
        .padding(.all, 12)
      }
      .background(Color(uiColor: UIColor.tertiarySystemBackground))
      .widgetURL(
        URL(string: "https://app.poap.xyz/scan/\(entry.address)")
      )
    }
  }
}

import WidgetHelpers

struct WidgetViewPreviews: PreviewProvider {
  static var previews: some View {
    WidgetPreview([.systemSmall]) {
      POAPWidget.WidgetView(
        entry: POAPWidget.Entry(
          date: Date(),
          data: [
            "https://assets.poap.xyz/i-met-kazushifukamieth-in-2023-2023-logo-1684503849953.png",
            "https://assets.poap.xyz/31cb94a2-0e1f-4fd3-8722-dbd48e95e2f8.png",
            "https://assets.poap.xyz/b86e7001-2d8c-4bd5-8497-43e6497bb07e.png",
            "https://assets.poap.xyz/ethglobal-tokyo-private-after-party-fwbxone-2023-logo-1681541518682.png",
          ].compactMap(URL.init(string:)).compactMap { try? Data(contentsOf: $0) },
          address: "tomokisun.eth"
        )
      )
    }
  }
}

extension UIImage {
  func resized(toWidth width: CGFloat, isOpaque: Bool = true) -> UIImage? {
    let canvas = CGSize(width: width, height: CGFloat(ceil(width / size.width * size.height)))
    let format = imageRendererFormat
    format.opaque = isOpaque
    return UIGraphicsImageRenderer(size: canvas, format: format).image {
      _ in draw(in: CGRect(origin: .zero, size: canvas))
    }
  }
}
