public struct AnalyticsClient {
  public var send: @Sendable (AnalyticsData) -> Void
}

public enum AnalyticsData {
  case event(name: String, properties: [String: String] = [:])
  case screen(name: String)
  case userId(String)
  case userProperty(name: String, value: String)
  case error(Error)
}
