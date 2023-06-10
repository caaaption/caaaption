// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

extension SnapshotModel {
  struct ProposalCardFragment: SnapshotModel.SelectionSet, Fragment {
    static var fragmentDefinition: StaticString { """
      fragment ProposalCardFragment on Proposal {
        __typename
        id
        title
      }
      """ }

    let __data: DataDict
    init(_dataDict: DataDict) { __data = _dataDict }

    static var __parentType: ApolloAPI.ParentType { SnapshotModel.Objects.Proposal }
    static var __selections: [ApolloAPI.Selection] { [
      .field("__typename", String.self),
      .field("id", String.self),
      .field("title", String.self),
    ] }

    var id: String { __data["id"] }
    var title: String { __data["title"] }
  }

}