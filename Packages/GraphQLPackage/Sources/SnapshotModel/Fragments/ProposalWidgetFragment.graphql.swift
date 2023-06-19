// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public extension SnapshotModel {
  struct ProposalWidgetFragment: SnapshotModel.SelectionSet, Fragment {
    public static var fragmentDefinition: StaticString { """
      fragment ProposalWidgetFragment on Proposal {
        __typename
        title
        choices
        scores
        link
      }
      """ }

    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { SnapshotModel.Objects.Proposal }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("__typename", String.self),
      .field("title", String.self),
      .field("choices", [String?].self),
      .field("scores", [Double?]?.self),
      .field("link", String?.self),
    ] }

    public var title: String { __data["title"] }
    public var choices: [String?] { __data["choices"] }
    public var scores: [Double?]? { __data["scores"] }
    public var link: String? { __data["link"] }
  }

}