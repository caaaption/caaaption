import ComposableArchitecture
import SwiftUI

public struct OnboardReducer: ReducerProtocol {
  public init() {}

  public struct State: Equatable {
    public var countryCode = CountryCodeReducer.State()
    
    @BindingState public var phoneNumber = ""
    @BindingState public var verificationCode = ""
    @BindingState public var displayName = ""
    @BindingState public var username = ""
    
    public init() {}
  }

  public enum Action: BindableAction, Equatable {
    case binding(BindingAction<State>)
    case countryCode(CountryCodeReducer.Action)
  }

  public var body: some ReducerProtocol<State, Action> {
    BindingReducer()
    Scope(state: \.countryCode, action: /Action.countryCode) {
      CountryCodeReducer()
    }
  }
}
