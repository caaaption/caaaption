// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

extension SnapshotModel {
  struct ProposalWidgetFragment: SnapshotModel.SelectionSet, Fragment {
    static var fragmentDefinition: StaticString { """
      fragment ProposalWidgetFragment on Proposal {
        __typename
        title
        choices
        scores
        state
      }
      """ }

    let __data: DataDict
    init(_dataDict: DataDict) { __data = _dataDict }

    static var __parentType: ApolloAPI.ParentType { SnapshotModel.Objects.Proposal }
    static var __selections: [ApolloAPI.Selection] { [
      .field("__typename", String.self),
      .field("title", String.self),
      .field("choices", [String?].self),
      .field("scores", [Double?]?.self),
      .field("state", String?.self),
    ] }

    var title: String { __data["title"] }
    var choices: [String?] { __data["choices"] }
    var scores: [Double?]? { __data["scores"] }
    var state: String? { __data["state"] }
  }

}