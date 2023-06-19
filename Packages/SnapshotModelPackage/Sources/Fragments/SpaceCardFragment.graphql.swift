// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public struct SpaceCardFragment: SnapshotModel.SelectionSet, Fragment {
  public static var fragmentDefinition: StaticString { """
    fragment SpaceCardFragment on Space {
      __typename
      id
      name
      followersCount
    }
    """ }

  public let __data: DataDict
  public init(_dataDict: DataDict) { __data = _dataDict }

  public static var __parentType: ApolloAPI.ParentType { SnapshotModel.Objects.Space }
  public static var __selections: [ApolloAPI.Selection] { [
    .field("__typename", String.self),
    .field("id", String.self),
    .field("name", String?.self),
    .field("followersCount", Int?.self),
  ] }

  public var id: String { __data["id"] }
  public var name: String? { __data["name"] }
  public var followersCount: Int? { __data["followersCount"] }
}
