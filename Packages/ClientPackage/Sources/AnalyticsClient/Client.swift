public struct AnalyticsClient {
  public var send: @Sendable (AnalyticsData) -> Void
  public var logEvent: @Sendable (LogEvent) -> Void
  public var setUserId: @Sendable (String) -> Void
  public var setUserProperty: @Sendable (UserProperty) -> Void
  public var setAnalyticsCollectionEnabled: @Sendable (Bool) -> Void
  
  public typealias LogEvent = (String, parameters: [String: Any]?)
  public typealias UserProperty = (value: String?, forName: String)
}

public enum AnalyticsData {
  case event(name: String, properties: [String: String] = [:])
  case screen(name: String)
  case userId(String)
  case userProperty(name: String, value: String)
  case error(Error)
}
