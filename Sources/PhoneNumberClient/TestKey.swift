import Foundation
import Dependencies
import PhoneNumberKit
import XCTestDynamicOverlay

extension DependencyValues {
  public var phoneNumberClient: PhoneNumberClient {
    get { self[PhoneNumberClient.self] }
    set { self[PhoneNumberClient.self] = newValue}
  }
}

extension PhoneNumberClient: TestDependencyKey {
  public static let previewValue = Self.live()
  public static let testValue = Self.live()
}
