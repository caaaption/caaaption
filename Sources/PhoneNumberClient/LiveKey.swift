import Dependencies
import PhoneNumberKit

extension PhoneNumberClient: DependencyKey {
  public static let liveValue = Self.live()
  
  static func live() -> Self {
    let phoneNumberKit = PhoneNumberKit()
    
    func parse(_ numberString: String) throws -> PhoneNumber {
      return try phoneNumberKit.parse(numberString)
    }
    
    func format(_ phoneNumber: PhoneNumber, toType formatType: PhoneNumberFormat) -> String {
      return phoneNumberKit.format(phoneNumber, toType: formatType)
    }
    
    func allCountries() -> [Country] {
      return phoneNumberKit
        .allCountries()
        .compactMap { Country(for: $0, with: phoneNumberKit) }
        .sorted(by: { $0.name.localizedCaseInsensitiveCompare($1.name) == .orderedAscending })
    }
    
    func initialCountries() -> [Character: [Country]] {
      var initialCountries: [Character: [Country]] = [:]
      allCountries().forEach { country in
        let key = country.name.first!
        if initialCountries[key] == nil {
          initialCountries[key] = []
        }
        initialCountries[key]?.append(country)
      }
      return initialCountries
    }
    
    return Self(
      parse: parse(_:),
      format: format(_:toType:),
      allCountries: allCountries,
      initialCountries: initialCountries
    )
  }
}
