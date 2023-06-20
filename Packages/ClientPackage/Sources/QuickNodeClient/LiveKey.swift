import APIKit
import Dependencies
import Foundation

extension QuickNodeClient: DependencyKey {
  public static let liveValue = Self(
    balance: { request in
      let response = try await APIKit.shared.send(request)
      let value = Int(strtoul(response.result, nil, 16))
      return Converter.toEther(wei: value)
    }
  )
}

enum Converter {
  static let etherInWei = pow(Decimal(10), 18)

  static func toEther(wei: Int) -> Decimal {
    guard let decimalWei = Decimal(string: wei.description) else {
      return 0.0
    }
    return decimalWei / etherInWei
  }
}
