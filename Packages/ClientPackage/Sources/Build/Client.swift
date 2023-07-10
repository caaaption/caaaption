import Foundation

public struct Build {
  public var bundleURL: () -> URL
  public var bundleIdentifier: () -> String?
  public var bundlePath: () -> String
  public var bundleName: () -> String
  public var bundleVersion: () -> Int
  public var bundleShortVersion: () -> String
}
