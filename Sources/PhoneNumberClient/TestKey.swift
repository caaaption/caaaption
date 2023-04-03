import Dependencies
import Foundation
import PhoneNumberKit
import XCTestDynamicOverlay

public extension DependencyValues {
  var phoneNumberClient: PhoneNumberClient {
    get { self[PhoneNumberClient.self] }
    set { self[PhoneNumberClient.self] = newValue }
  }
}

extension PhoneNumberClient: TestDependencyKey {
  public static let previewValue = Self.live()
  public static let testValue = Self.live()
}
