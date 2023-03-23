import PhoneNumberClient
import ComposableArchitecture

public struct CountryCodeReducer: ReducerProtocol {
  public struct State: Equatable {
    public var query = ""
    public var sections: [Character: [Country]] = [:]
  }
  
  public enum Action: Equatable {
    case task
    case searchable(String)
  }
  
  @Dependency(\.phoneNumberClient) var phoneNumberClient
  
  public func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
    switch action {
    case .task:
      state.sections = phoneNumberClient.initialCountries()
      return EffectTask.none
    
    case let .searchable(query):
      state.query = query
      return EffectTask.none
    }
  }
}
