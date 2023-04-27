// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

public protocol SnapshotGraphQLModel_SelectionSet: ApolloAPI.SelectionSet & ApolloAPI.RootSelectionSet
where Schema == SnapshotGraphQLModel.SchemaMetadata {}

public protocol SnapshotGraphQLModel_InlineFragment: ApolloAPI.SelectionSet & ApolloAPI.InlineFragment
where Schema == SnapshotGraphQLModel.SchemaMetadata {}

public protocol SnapshotGraphQLModel_MutableSelectionSet: ApolloAPI.MutableRootSelectionSet
where Schema == SnapshotGraphQLModel.SchemaMetadata {}

public protocol SnapshotGraphQLModel_MutableInlineFragment: ApolloAPI.MutableSelectionSet & ApolloAPI.InlineFragment
where Schema == SnapshotGraphQLModel.SchemaMetadata {}

public extension SnapshotGraphQLModel {
  typealias ID = String

  typealias SelectionSet = SnapshotGraphQLModel_SelectionSet

  typealias InlineFragment = SnapshotGraphQLModel_InlineFragment

  typealias MutableSelectionSet = SnapshotGraphQLModel_MutableSelectionSet

  typealias MutableInlineFragment = SnapshotGraphQLModel_MutableInlineFragment

  enum SchemaMetadata: ApolloAPI.SchemaMetadata {
    public static let configuration: ApolloAPI.SchemaConfiguration.Type = SchemaConfiguration.self

    public static func objectType(forTypename typename: String) -> Object? {
      switch typename {
      case "Query": return SnapshotGraphQLModel.Objects.Query
      case "Proposal": return SnapshotGraphQLModel.Objects.Proposal
      case "Space": return SnapshotGraphQLModel.Objects.Space
      default: return nil
      }
    }
  }

  enum Objects {}
  enum Interfaces {}
  enum Unions {}

}