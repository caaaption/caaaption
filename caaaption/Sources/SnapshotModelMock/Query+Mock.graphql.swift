// @generated
// This file was automatically generated and should not be edited.

import ApolloTestSupport
import SnapshotModel

public class Query: MockObject {
  public static let objectType: Object = SnapshotModel.Objects.Query
  public static let _mockFields = MockFields()
  public typealias MockValueCollectionType = Array<Mock<Query>>

  public struct MockFields {
    @Field<Proposal>("proposal") public var proposal
    @Field<[Proposal?]>("proposals") public var proposals
    @Field<[Space?]>("spaces") public var spaces
  }
}

public extension Mock where O == Query {
  convenience init(
    proposal: Mock<Proposal>? = nil,
    proposals: [Mock<Proposal>?]? = nil,
    spaces: [Mock<Space>?]? = nil
  ) {
    self.init()
    _set(proposal, for: \.proposal)
    _set(proposals, for: \.proposals)
    _set(spaces, for: \.spaces)
  }
}
