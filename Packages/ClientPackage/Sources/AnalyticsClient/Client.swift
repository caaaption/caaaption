public struct AnalyticsClient {
  public var logEvent: @Sendable (LogEvent) -> Void
  public var setUserId: @Sendable (String) -> Void
  public var setUserProperty: @Sendable (UserProperty) -> Void
  public var setAnalyticsCollectionEnabled: @Sendable (Bool) -> Void

  public typealias LogEvent = (String, parameters: [String: Any]?)
  public typealias UserProperty = (value: String?, forName: String)
}
