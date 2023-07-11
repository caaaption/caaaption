import Dependencies
import FirebaseAnalytics

extension AnalyticsClient: DependencyKey {
  public static let liveValue = Self(
    send: Self.consoleLogger.send,
    logEvent: { Analytics.logEvent($0, parameters: $1) },
    setAnalyticsCollectionEnabled: { Analytics.setAnalyticsCollectionEnabled($0) }
  )
}
