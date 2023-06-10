import Dependencies
import Foundation

extension UserDefaultsClient: DependencyKey {
  public static let liveValue: Self = {
    let appGroup = Bundle.main.infoDictionary?["AppGroup"] as? String
    let suiteName = appGroup ?? "group.com.caaaption-staging"
    print("suiteName : \(suiteName)")
    return Self.live(suiteName: suiteName)
  }()

  private static func live(suiteName: String) -> Self {
    let defaults = { UserDefaults(suiteName: suiteName)! }

    return Self(
      boolForKey: { defaults().bool(forKey: $0) },
      dataForKey: { defaults().data(forKey: $0) },
      doubleForKey: { defaults().double(forKey: $0) },
      integerForKey: { defaults().integer(forKey: $0) },
      remove: { defaults().removeObject(forKey: $0) },
      setBool: { defaults().set($0, forKey: $1) },
      setData: { defaults().set($0, forKey: $1) },
      setDouble: { defaults().set($0, forKey: $1) },
      setInteger: { defaults().set($0, forKey: $1) }
    )
  }
}
