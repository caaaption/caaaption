import Dependencies
import XCTestDynamicOverlay

public extension DependencyValues {
  var widgetClient: WidgetClient {
    get { self[WidgetClient.self] }
    set { self[WidgetClient.self] = newValue }
  }
}

extension WidgetClient: TestDependencyKey {
  public static let previewValue = Self.noop
  
  public static let testValue = Self(
    reloadAllTimelines: unimplemented("\(Self.self).reloadAllTimelines")
  )
}

public extension WidgetClient {
  static let noop = Self(
    reloadAllTimelines: {  }
  )
}
