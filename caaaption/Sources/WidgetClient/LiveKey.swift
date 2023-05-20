import Dependencies
import WidgetKit

extension WidgetClient: DependencyKey {
  public static let liveValue = Self(
    reloadAllTimelines: { WidgetCenter.shared.reloadAllTimelines() }
  )
}
