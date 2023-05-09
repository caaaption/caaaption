import ApolloHelpers
import ComposableArchitecture
import SnapshotModel

public typealias Proposal = WrappedIdentifiable<SnapshotModel.ProposalCardFragment>

public struct ProposalsReducer: ReducerProtocol {
  public init() {}

  public struct State: Equatable {
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
    case tappedProposal(Proposal)

    public enum Dialog {
      case confirmDiscard
      case confirmAddWidget
    }
  }

  public var body: some ReducerProtocol<State, Action> {
    Reduce { state, action in
      switch action {
      case .dialog(.presented(.confirmAddWidget)):
        print("confirm add widget")
        return EffectTask.none

      case .dialog:
        return EffectTask.none

      case let .tappedProposal(proposal):
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
