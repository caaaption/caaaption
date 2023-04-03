import ComposableArchitecture
import SwiftUI

public struct OnboardReducer: ReducerProtocol {
  public init() {}

  public struct State: Equatable {
    public var countryCode = CountryCodeReducer.State()

    @BindingState public var displayName = ""
    @BindingState public var username = ""

    public init() {}
  }

  public enum Action: BindableAction, Equatable {
    case countryCode(CountryCodeReducer.Action)

    case binding(BindingAction<State>)
  }

  public var body: some ReducerProtocol<State, Action> {
    BindingReducer()
    Scope(state: \.countryCode, action: /Action.countryCode) {
      CountryCodeReducer()
    }
    Reduce { _, action in
      switch action {
      case .countryCode:
        return EffectTask.none

      case .binding:
        return EffectTask.none
      }
    }
  }
}
