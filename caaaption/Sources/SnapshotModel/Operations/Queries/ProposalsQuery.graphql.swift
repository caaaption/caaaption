// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public extension SnapshotModel {
  class ProposalsQuery: GraphQLQuery {
    public static let operationName: String = "Proposals"
    public static let document: ApolloAPI.DocumentType = .notPersisted(
      definition: .init(
        #"""
        query Proposals($spaceName: String!) {
          proposals(
            first: 200
            where: {space_in: [$spaceName]}
            orderBy: "created"
            orderDirection: desc
          ) {
            __typename
            id
            created
            ipfs
            title
            body
            choices
            scores
            state
          }
        }
        """#
      ))

    public var spaceName: String

    public init(spaceName: String) {
      self.spaceName = spaceName
    }

    public var __variables: Variables? { ["spaceName": spaceName] }

    public struct Data: SnapshotModel.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { SnapshotModel.Objects.Query }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("proposals", [Proposal?]?.self, arguments: [
          "first": 200,
          "where": ["space_in": [.variable("spaceName")]],
          "orderBy": "created",
          "orderDirection": "desc"
        ]),
      ] }

      public var proposals: [Proposal?]? { __data["proposals"] }

      /// Proposal
      ///
      /// Parent Type: `Proposal`
      public struct Proposal: SnapshotModel.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { SnapshotModel.Objects.Proposal }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("id", String.self),
          .field("created", Int.self),
          .field("ipfs", String?.self),
          .field("title", String.self),
          .field("body", String?.self),
          .field("choices", [String?].self),
          .field("scores", [Double?]?.self),
          .field("state", String?.self),
        ] }

        public var id: String { __data["id"] }
        public var created: Int { __data["created"] }
        public var ipfs: String? { __data["ipfs"] }
        public var title: String { __data["title"] }
        public var body: String? { __data["body"] }
        public var choices: [String?] { __data["choices"] }
        public var scores: [Double?]? { __data["scores"] }
        public var state: String? { __data["state"] }
      }
    }
  }

}