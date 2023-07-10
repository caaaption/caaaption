import Dependencies
import FirebaseAnalytics

extension AnalyticsClient: DependencyKey {
  public static let liveValue = Self(
    send: Self.consoleLogger.send,
    setAnalyticsCollectionEnabled: { Analytics.setAnalyticsCollectionEnabled($0) }
  )
}
