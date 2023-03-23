import SwiftUI
import ComposableArchitecture

public struct OnboardReducer: ReducerProtocol {
  public init() {}
  
  public struct State: Equatable {
    public var countryCode = CountryCodeReducer.State()
    
    public var displayName = ""
    public var username = ""
    
    public init() {}
  }
  
  public enum Action: Equatable {
    case countryCode(CountryCodeReducer.Action)
    
    case changedDisplayName(String)
    case changedUsername(String)
  }
  
  public var body: some ReducerProtocol<State, Action> {
    Scope(state: \.countryCode, action: /Action.countryCode) {
      CountryCodeReducer()
    }
    Reduce { state, action in
      switch action {
      case .countryCode:
        return EffectTask.none
        
      case let .changedDisplayName(displayName):
        state.displayName = displayName
        return EffectTask.none
      
      case let .changedUsername(username):
        state.username = username
        return EffectTask.none
      }
    }
  }
}
