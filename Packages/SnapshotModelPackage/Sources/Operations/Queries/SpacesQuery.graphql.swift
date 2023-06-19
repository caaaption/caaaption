// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class SpacesQuery: GraphQLQuery {
  public static let operationName: String = "Spaces"
  public static let document: ApolloAPI.DocumentType = .notPersisted(
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

  public struct Data: SnapshotModel.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { SnapshotModel.Objects.Query }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("spaces", [Space?]?.self, arguments: [
        "where": ["id_in": .variable("idIn")],
        "first": 1000
      ]),
    ] }

    public var spaces: [Space?]? { __data["spaces"] }

    /// Space
    ///
    /// Parent Type: `Space`
    public struct Space: SnapshotModel.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { SnapshotModel.Objects.Space }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .fragment(SpaceCardFragment.self),
      ] }

      public var id: String { __data["id"] }
      public var name: String? { __data["name"] }
      public var followersCount: Int? { __data["followersCount"] }

      public struct Fragments: FragmentContainer {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public var spaceCardFragment: SpaceCardFragment { _toFragment() }
      }
    }
  }
}
