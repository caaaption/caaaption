// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

extension SnapshotModel {
  class ProposalQuery: GraphQLQuery {
    static let operationName: String = "Proposal"
    static let document: ApolloAPI.DocumentType = .notPersisted(
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

    struct Data: SnapshotModel.SelectionSet {
      let __data: DataDict
      init(_dataDict: DataDict) { __data = _dataDict }

      static var __parentType: ApolloAPI.ParentType { SnapshotModel.Objects.Query }
      static var __selections: [ApolloAPI.Selection] { [
        .field("proposal", Proposal?.self, arguments: ["id": .variable("id")]),
      ] }

      var proposal: Proposal? { __data["proposal"] }

      /// Proposal
      ///
      /// Parent Type: `Proposal`
      struct Proposal: SnapshotModel.SelectionSet {
        let __data: DataDict
        init(_dataDict: DataDict) { __data = _dataDict }

        static var __parentType: ApolloAPI.ParentType { SnapshotModel.Objects.Proposal }
        static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .fragment(ProposalWidgetFragment.self),
        ] }

        var title: String { __data["title"] }
        var choices: [String?] { __data["choices"] }
        var scores: [Double?]? { __data["scores"] }
        var state: String? { __data["state"] }

        struct Fragments: FragmentContainer {
          let __data: DataDict
          init(_dataDict: DataDict) { __data = _dataDict }

          var proposalWidgetFragment: ProposalWidgetFragment { _toFragment() }
        }
      }
    }
  }

}