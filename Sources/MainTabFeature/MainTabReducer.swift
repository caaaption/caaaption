import ComposableArchitecture
import FeedFeature
import ProfileFeature
import SwiftUI
import UploadFeature

public struct MainTabReducer: ReducerProtocol {
  public init() {}

  public struct State: Equatable {
    public var feed = FeedReducer.State()
    public var profile = ProfileReducer.State()

    public var upload = UploadReducer.State()
    public var contentTypeModal = ContentTypeModalReducer.State()

    public var tab = Tab.feed

    @BindingState public var contentTypeModalPresented = false
    @BindingState public var uploadPresented = false

    public init() {}

    public enum Tab: Equatable {
      case feed
      case mypage
    }
  }

  public enum Action: BindableAction, Equatable {
    case feed(FeedReducer.Action)
    case profile(ProfileReducer.Action)

    case upload(UploadReducer.Action)
    case contentTypeModal(ContentTypeModalReducer.Action)

    case actionFeed
    case actionMypage

    case binding(BindingAction<State>)
  }

  public var body: some ReducerProtocol<State, Action> {
    BindingReducer()
    Scope(state: \.feed, action: /Action.feed) {
      FeedReducer()
    }
    Scope(state: \.profile, action: /Action.profile) {
      ProfileReducer()
    }
    Scope(state: \.upload, action: /Action.upload) {
      UploadReducer()
    }
    Scope(state: \.contentTypeModal, action: /Action.contentTypeModal) {
      ContentTypeModalReducer()
    }
    Reduce { state, action in
      switch action {
      case .contentTypeModal(.photoLibraryTapped):
        return EffectTask.run { send in
          await send(.binding(.set(\.$contentTypeModalPresented, false)))
          await send(.binding(.set(\.$uploadPresented, true)))
        }
      case .feed, .profile, .upload, .contentTypeModal, .binding:
        return EffectTask.none

      case .actionFeed:
        state.tab = .feed
        return EffectTask.none

      case .actionMypage:
        state.tab = .mypage
        return EffectTask.none
      }
    }
  }
}
