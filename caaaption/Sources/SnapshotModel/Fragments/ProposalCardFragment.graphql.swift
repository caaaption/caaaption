// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public extension SnapshotModel {
  struct ProposalCardFragment: SnapshotModel.SelectionSet, Fragment {
    public static var fragmentDefinition: StaticString { """
      fragment ProposalCardFragment on Proposal {
        __typename
        id
        created
        title
        state
      }
      """ }

    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { SnapshotModel.Objects.Proposal }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("__typename", String.self),
      .field("id", String.self),
      .field("created", Int.self),
      .field("title", String.self),
      .field("state", String?.self),
    ] }

    public var id: String { __data["id"] }
    public var created: Int { __data["created"] }
    public var title: String { __data["title"] }
    public var state: String? { __data["state"] }
  }

}