import ApolloHelpers
import ComposableArchitecture
import SnapshotModel
import SwiftUI
import UserDefaultsClient
import VoteWidget

public typealias Proposal = WrappedIdentifiable<SnapshotModel.ProposalCardFragment>

public struct ProposalsReducer: ReducerProtocol {
  public init() {}

  public struct State: Equatable {
    public var selection: Proposal?
    public var proposals: IdentifiedArrayOf<Proposal>
    @PresentationState var dialog: ConfirmationDialogState<Action.Dialog>?

    public init(
      proposals: IdentifiedArrayOf<Proposal>
    ) {
      self.proposals = proposals
    }
  }

  public enum Action: Equatable {
    case dialog(PresentationAction<Dialog>)
    case proposalButtonTapped(Proposal)

    public enum Dialog {
      case confirmDiscard
      case confirmAddWidget
    }
  }
  
  @Dependency(\.userDefaults) var userDefaults

  public var body: some ReducerProtocol<State, Action> {
    Reduce { state, action in
      switch action {
      case .dialog(.presented(.confirmAddWidget)):
        guard let proposalId = state.selection?.value.id else {
          return EffectTask.none
        }
        return .run { _ in
          let input = VoteWidget.Input(proposalId: proposalId)
          await userDefaults.setCodable(input, forKey: VoteWidget.Constant.kind)
        }

      case .dialog:
        return EffectTask.none

      case let .proposalButtonTapped(proposal):
        state.selection = proposal
        state.dialog = ConfirmationDialogState(titleVisibility: .visible) {
          TextState("Display in Widget.")
        } actions: {
          ButtonState(action: .confirmAddWidget) {
            TextState("Add widget")
          }
          ButtonState(role: .cancel, action: .confirmDiscard) {
            TextState("Cancel")
          }
        } message: {
          TextState(
            """
            "\(proposal.value.title)" in the Widget.
            """
          )
        }
        return EffectTask.none
      }
    }
    .ifLet(\.$dialog, action: /Action.dialog)
  }
}

public struct ProposalsView: View {
  let store: StoreOf<ProposalsReducer>

  public init(store: StoreOf<ProposalsReducer>) {
    self.store = store
  }

  public var body: some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
      List {
        ForEach(viewStore.proposals) { proposal in
          Button {
            viewStore.send(.proposalButtonTapped(proposal))
          } label: {
            Text(proposal.value.title)
              .foregroundColor(.primary)
          }
        }
      }
      .navigationTitle("Proposals")
      .navigationBarTitleDisplayMode(.inline)
      .confirmationDialog(
        store: store.scope(
          state: \.$dialog,
          action: ProposalsReducer.Action.dialog
        )
      )
    }
  }
}
