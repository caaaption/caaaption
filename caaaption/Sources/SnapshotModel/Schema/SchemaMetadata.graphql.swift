// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

public protocol SnapshotModel_SelectionSet: ApolloAPI.SelectionSet & ApolloAPI.RootSelectionSet
where Schema == SnapshotModel.SchemaMetadata {}

public protocol SnapshotModel_InlineFragment: ApolloAPI.SelectionSet & ApolloAPI.InlineFragment
where Schema == SnapshotModel.SchemaMetadata {}

public protocol SnapshotModel_MutableSelectionSet: ApolloAPI.MutableRootSelectionSet
where Schema == SnapshotModel.SchemaMetadata {}

public protocol SnapshotModel_MutableInlineFragment: ApolloAPI.MutableSelectionSet & ApolloAPI.InlineFragment
where Schema == SnapshotModel.SchemaMetadata {}

public extension SnapshotModel {
  typealias ID = String

  typealias SelectionSet = SnapshotModel_SelectionSet

  typealias InlineFragment = SnapshotModel_InlineFragment

  typealias MutableSelectionSet = SnapshotModel_MutableSelectionSet

  typealias MutableInlineFragment = SnapshotModel_MutableInlineFragment

  enum SchemaMetadata: ApolloAPI.SchemaMetadata {
    public static let configuration: ApolloAPI.SchemaConfiguration.Type = SchemaConfiguration.self

    public static func objectType(forTypename typename: String) -> Object? {
      switch typename {
      case "Query": return SnapshotModel.Objects.Query
      case "Proposal": return SnapshotModel.Objects.Proposal
      case "Space": return SnapshotModel.Objects.Space
      default: return nil
      }
    }
  }

  enum Objects {}
  enum Interfaces {}
  enum Unions {}

}