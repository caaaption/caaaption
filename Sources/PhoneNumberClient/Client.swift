import PhoneNumberKit
import ComposableArchitecture

public struct PhoneNumberClient {
  /// Parses a number string, used to create PhoneNumber objects. Throws.
  ///
  /// - Parameters:
  ///   - numberString: the raw number string.
  /// - Returns: PhoneNumber object.
  public let parse: (String) throws -> PhoneNumber
  
  /// Formats a PhoneNumber object for display.
  ///
  /// - parameter phoneNumber: PhoneNumber object.
  /// - parameter formatType:  PhoneNumberFormat enum.
  ///
  /// - returns: Formatted representation of the PhoneNumber.
  public let format: (PhoneNumber, PhoneNumberFormat) -> String
  
  /// Get a list of all the countries in the metadata database
  ///
  /// - returns: An array of Countries.
  public let allCountries: () -> [Country]
  
  public let initialCountries: () -> [Character: [Country]]
  
  public init(
    parse: @escaping (String) throws -> PhoneNumber,
    format: @escaping (PhoneNumber, PhoneNumberFormat) -> String,
    allCountries: @escaping () -> [Country],
    initialCountries: @escaping () -> [Character: [Country]]
  ) {
    self.parse = parse
    self.format = format
    self.allCountries = allCountries
    self.initialCountries = initialCountries
  }
}
