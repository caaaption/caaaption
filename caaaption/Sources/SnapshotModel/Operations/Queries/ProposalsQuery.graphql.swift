// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

extension SnapshotModel {
  class ProposalsQuery: GraphQLQuery {
    static let operationName: String = "Proposals"
    static let document: ApolloAPI.DocumentType = .notPersisted(
      definition: .init(
        #"""
        query Proposals($spaceName: String!) {
          proposals(
            first: 1000
            where: {space_in: [$spaceName]}
            orderBy: "created"
            orderDirection: desc
          ) {
            __typename
            ...ProposalCardFragment
          }
        }
        """#,
        fragments: [ProposalCardFragment.self]
      ))

    public var spaceName: String

    public init(spaceName: String) {
      self.spaceName = spaceName
    }

    public var __variables: Variables? { ["spaceName": spaceName] }

    struct Data: SnapshotModel.SelectionSet {
      let __data: DataDict
      init(_dataDict: DataDict) { __data = _dataDict }

      static var __parentType: ApolloAPI.ParentType { SnapshotModel.Objects.Query }
      static var __selections: [ApolloAPI.Selection] { [
        .field("proposals", [Proposal?]?.self, arguments: [
          "first": 1000,
          "where": ["space_in": [.variable("spaceName")]],
          "orderBy": "created",
          "orderDirection": "desc"
        ]),
      ] }

      var proposals: [Proposal?]? { __data["proposals"] }

      /// Proposal
      ///
      /// Parent Type: `Proposal`
      struct Proposal: SnapshotModel.SelectionSet {
        let __data: DataDict
        init(_dataDict: DataDict) { __data = _dataDict }

        static var __parentType: ApolloAPI.ParentType { SnapshotModel.Objects.Proposal }
        static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .fragment(ProposalCardFragment.self),
        ] }

        var id: String { __data["id"] }
        var title: String { __data["title"] }

        struct Fragments: FragmentContainer {
          let __data: DataDict
          init(_dataDict: DataDict) { __data = _dataDict }

          var proposalCardFragment: ProposalCardFragment { _toFragment() }
        }
      }
    }
  }

}