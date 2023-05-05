// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public extension SnapshotModel {
  class ProposalQuery: GraphQLQuery {
    public static let operationName: String = "Proposal"
    public static let document: ApolloAPI.DocumentType = .notPersisted(
      definition: .init(
        #"""
        query Proposal($id: String!) {
          proposal(id: $id) {
            __typename
            ...ProposalWidgetFragment
          }
        }
        """#,
        fragments: [ProposalWidgetFragment.self]
      ))

    public var id: String

    public init(id: String) {
      self.id = id
    }

    public var __variables: Variables? { ["id": id] }

    public struct Data: SnapshotModel.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { SnapshotModel.Objects.Query }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("proposal", Proposal?.self, arguments: ["id": .variable("id")]),
      ] }

      public var proposal: Proposal? { __data["proposal"] }

      /// Proposal
      ///
      /// Parent Type: `Proposal`
      public struct Proposal: SnapshotModel.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { SnapshotModel.Objects.Proposal }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .fragment(ProposalWidgetFragment.self),
        ] }

        public var title: String { __data["title"] }
        public var choices: [String?] { __data["choices"] }
        public var scores: [Double?]? { __data["scores"] }

        public struct Fragments: FragmentContainer {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public var proposalWidgetFragment: ProposalWidgetFragment { _toFragment() }
        }
      }
    }
  }

}
