import Foundation
import PhoneNumberKit

public struct Country: Equatable, Hashable {
  public let code: String
  public let flag: String
  public let name: String
  public let prefix: String

  public init?(for countryCode: String, with phoneNumberKit: PhoneNumberKit) {
    let flagBase = UnicodeScalar("🇦").value - UnicodeScalar("A").value
    guard
      let name = (Locale.current as NSLocale).localizedString(forCountryCode: countryCode),
      let prefix = phoneNumberKit.countryCode(for: countryCode)?.description
    else {
      return nil
    }

    code = countryCode
    self.name = name
    self.prefix = "+" + prefix
    var _flag = ""
    countryCode.uppercased().unicodeScalars.forEach {
      if let scaler = UnicodeScalar(flagBase + $0.value) {
        _flag.append(String(describing: scaler))
      }
    }
    flag = _flag
    if flag.count != 1 { // Failed to initialize a flag ... use an empty string
      return nil
    }
  }
}
