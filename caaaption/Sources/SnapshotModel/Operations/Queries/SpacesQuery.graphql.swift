// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

extension SnapshotModel {
  class SpacesQuery: GraphQLQuery {
    static let operationName: String = "Spaces"
    static let document: ApolloAPI.DocumentType = .notPersisted(
      definition: .init(
        #"""
        query Spaces($idIn: [String]) {
          spaces(where: {id_in: $idIn}, first: 1000) {
            __typename
            ...SpaceCardFragment
          }
        }
        """#,
        fragments: [SpaceCardFragment.self]
      ))

    public var idIn: GraphQLNullable<[String?]>

    public init(idIn: GraphQLNullable<[String?]>) {
      self.idIn = idIn
    }

    public var __variables: Variables? { ["idIn": idIn] }

    struct Data: SnapshotModel.SelectionSet {
      let __data: DataDict
      init(_dataDict: DataDict) { __data = _dataDict }

      static var __parentType: ApolloAPI.ParentType { SnapshotModel.Objects.Query }
      static var __selections: [ApolloAPI.Selection] { [
        .field("spaces", [Space?]?.self, arguments: [
          "where": ["id_in": .variable("idIn")],
          "first": 1000
        ]),
      ] }

      var spaces: [Space?]? { __data["spaces"] }

      /// Space
      ///
      /// Parent Type: `Space`
      struct Space: SnapshotModel.SelectionSet {
        let __data: DataDict
        init(_dataDict: DataDict) { __data = _dataDict }

        static var __parentType: ApolloAPI.ParentType { SnapshotModel.Objects.Space }
        static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .fragment(SpaceCardFragment.self),
        ] }

        var id: String { __data["id"] }
        var name: String? { __data["name"] }
        var followersCount: Int? { __data["followersCount"] }

        struct Fragments: FragmentContainer {
          let __data: DataDict
          init(_dataDict: DataDict) { __data = _dataDict }

          var spaceCardFragment: SpaceCardFragment { _toFragment() }
        }
      }
    }
  }

}