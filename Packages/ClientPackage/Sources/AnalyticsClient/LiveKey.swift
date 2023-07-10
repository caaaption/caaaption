import Dependencies
import FirebaseAnalytics

extension AnalyticsClient: DependencyKey {
  public static let liveValue = Self(
    send: { analyticsData in
      switch analyticsData {
      case let .event(name, properties):
        print("[\(name)]...\(properties)")
        Analytics.logEvent(name, parameters: properties)
      case let .screen(name):
        print(name)
      case let .userId(userId):
        Analytics.setUserID(userId)
      case let .userProperty(name, value):
        Analytics.setUserProperty(value, forName: name)
      case let .error(error):
        print(error)
      }
    }
  )
}
