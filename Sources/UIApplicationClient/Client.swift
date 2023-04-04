import UIKit

public struct UIApplicationClient {
  public var alternateIconName: () -> String?
  public var alternateIconNameAsync: @Sendable () async -> String?
  public var open: @Sendable (URL, [UIApplication.OpenExternalURLOptionsKey: Any]) async -> Bool
  public var openSettingsURLString: @Sendable () async -> String
  public var setAlternateIconName: @Sendable (String?) async throws -> Void
  public var setUserInterfaceStyle: @Sendable (UIUserInterfaceStyle) async -> Void
  @available(*, deprecated) public var supportsAlternateIcons: () -> Bool
  public var supportsAlternateIconsAsync: @Sendable () async -> Bool
}
