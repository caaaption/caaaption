// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

protocol SnapshotModel_SelectionSet: ApolloAPI.SelectionSet & ApolloAPI.RootSelectionSet
where Schema == SnapshotModel.SchemaMetadata {}

protocol SnapshotModel_InlineFragment: ApolloAPI.SelectionSet & ApolloAPI.InlineFragment
where Schema == SnapshotModel.SchemaMetadata {}

protocol SnapshotModel_MutableSelectionSet: ApolloAPI.MutableRootSelectionSet
where Schema == SnapshotModel.SchemaMetadata {}

protocol SnapshotModel_MutableInlineFragment: ApolloAPI.MutableSelectionSet & ApolloAPI.InlineFragment
where Schema == SnapshotModel.SchemaMetadata {}

extension SnapshotModel {
  typealias ID = String

  typealias SelectionSet = SnapshotModel_SelectionSet

  typealias InlineFragment = SnapshotModel_InlineFragment

  typealias MutableSelectionSet = SnapshotModel_MutableSelectionSet

  typealias MutableInlineFragment = SnapshotModel_MutableInlineFragment

  enum SchemaMetadata: ApolloAPI.SchemaMetadata {
    static let configuration: ApolloAPI.SchemaConfiguration.Type = SchemaConfiguration.self

    static func objectType(forTypename typename: String) -> Object? {
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