// @generated
// This file was automatically generated and should not be edited.

import ApolloTestSupport
import SnapshotModel

public class Query: MockObject {
  public static let objectType: Object = SnapshotModel.Objects.Query
  public static let _mockFields = MockFields()
  public typealias MockValueCollectionType = [Mock<Query>]

  public struct MockFields {
    @Field<Proposal>("proposal") public var proposal
    @Field<[Proposal?]>("proposals") public var proposals
  }
}

public extension Mock where O == Query {
  convenience init(
    proposal: Mock<Proposal>? = nil,
    proposals: [Mock<Proposal>?]? = nil
  ) {
    self.init()
    self.proposal = proposal
    self.proposals = proposals
  }
}
