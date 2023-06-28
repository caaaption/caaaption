import AnalyticsClient
import ComposableArchitecture
import Foundation

public struct AnalyticsReducer<State, Action>: ReducerProtocol {
  @usableFromInline
  let toAnalyticsData: (State, Action) -> AnalyticsData?

  @usableFromInline
  @Dependency(\.analytics) var analytics

  @inlinable
  public init(_ toAnalyticsData: @escaping (State, Action) -> AnalyticsData?) {
    self.init(toAnalyticsData: toAnalyticsData, internal: ())
  }

  @usableFromInline
  init(toAnalyticsData: @escaping (State, Action) -> AnalyticsData?, internal: Void) {
    self.toAnalyticsData = toAnalyticsData
  }

  @inlinable
  public func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
    guard let analyticsData = toAnalyticsData(state, action) else {
      return .none
    }

    return .run { _ in
      analytics.send(analyticsData)
    }
  }
}
