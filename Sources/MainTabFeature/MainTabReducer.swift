import ComposableArchitecture
import FeedFeature
import ProfileFeature
import SwiftUI
import UploadFeature

public struct MainTabReducer: ReducerProtocol {
  public init() {}

  public struct State: Equatable {
    public var feed = FeedReducer.State()
    public var upload = UploadReducer.State()
    public var profile = ProfileReducer.State()

    public var tab = Tab.feed
    public var isSheetPresented = false

    public init() {}

    public enum Tab: Equatable {
      case feed
      case mypage
    }
  }

  public enum Action: Equatable {
    case feed(FeedReducer.Action)
    case upload(UploadReducer.Action)
    case profile(ProfileReducer.Action)
    case actionFeed
    case actionMypage
    case setSheet(isPresented: Bool)
  }

  public var body: some ReducerProtocol<State, Action> {
    Scope(state: \.feed, action: /Action.feed) {
      FeedReducer()
    }
    Scope(state: \.upload, action: /Action.upload) {
      UploadReducer()
    }
    Scope(state: \.profile, action: /Action.profile) {
      ProfileReducer()
    }
    Reduce { state, action in
      switch action {
      case .feed, .upload, .profile:
        return EffectTask.none

      case .actionFeed:
        state.tab = .feed
        return EffectTask.none

      case .actionMypage:
        state.tab = .mypage
        return EffectTask.none

      case let .setSheet(isPresented):
        state.isSheetPresented = isPresented
        return EffectTask.none
      }
    }
  }
}
