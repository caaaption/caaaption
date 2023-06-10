// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

extension SnapshotModel {
  struct SpaceCardFragment: SnapshotModel.SelectionSet, Fragment {
    static var fragmentDefinition: StaticString { """
      fragment SpaceCardFragment on Space {
        __typename
        id
        name
        followersCount
      }
      """ }

    let __data: DataDict
    init(_dataDict: DataDict) { __data = _dataDict }

    static var __parentType: ApolloAPI.ParentType { SnapshotModel.Objects.Space }
    static var __selections: [ApolloAPI.Selection] { [
      .field("__typename", String.self),
      .field("id", String.self),
      .field("name", String?.self),
      .field("followersCount", Int?.self),
    ] }

    var id: String { __data["id"] }
    var name: String? { __data["name"] }
    var followersCount: Int? { __data["followersCount"] }
  }

}