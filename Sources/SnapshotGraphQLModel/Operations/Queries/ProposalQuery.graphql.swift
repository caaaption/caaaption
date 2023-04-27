// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public extension SnapshotGraphQLModel {
  class ProposalQuery: GraphQLQuery {
    public static let operationName: String = "Proposal"
    public static let document: ApolloAPI.DocumentType = .notPersisted(
      definition: .init(
        #"""
        query Proposal($id: String!) {
          proposal(id: $id) {
            __typename
            title
            choices
            scores
            space {
              __typename
              name
            }
          }
        }
        """#
      ))

    public var id: String

    public init(id: String) {
      self.id = id
    }

    public var __variables: Variables? { ["id": id] }

    public struct Data: SnapshotGraphQLModel.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { SnapshotGraphQLModel.Objects.Query }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("proposal", Proposal?.self, arguments: ["id": .variable("id")]),
      ] }

      public var proposal: Proposal? { __data["proposal"] }

      /// Proposal
      ///
      /// Parent Type: `Proposal`
      public struct Proposal: SnapshotGraphQLModel.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { SnapshotGraphQLModel.Objects.Proposal }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("title", String.self),
          .field("choices", [String?].self),
          .field("scores", [Double?]?.self),
          .field("space", Space?.self),
        ] }

        public var title: String { __data["title"] }
        public var choices: [String?] { __data["choices"] }
        public var scores: [Double?]? { __data["scores"] }
        public var space: Space? { __data["space"] }

        /// Proposal.Space
        ///
        /// Parent Type: `Space`
        public struct Space: SnapshotGraphQLModel.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: ApolloAPI.ParentType { SnapshotGraphQLModel.Objects.Space }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("name", String?.self),
          ] }

          public var name: String? { __data["name"] }
        }
      }
    }
  }

}