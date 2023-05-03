// @generated
// This file was automatically generated and should not be edited.

import ApolloTestSupport
import SnapshotModel

public class Proposal: MockObject {
  public static let objectType: Object = SnapshotModel.Objects.Proposal
  public static let _mockFields = MockFields()
  public typealias MockValueCollectionType = Array<Mock<Proposal>>

  public struct MockFields {
    @Field<String>("body") public var body
    @Field<[String?]>("choices") public var choices
    @Field<Int>("created") public var created
    @Field<String>("id") public var id
    @Field<String>("ipfs") public var ipfs
    @Field<[Double?]>("scores") public var scores
    @Field<Space>("space") public var space
    @Field<String>("state") public var state
    @Field<String>("title") public var title
  }
}

public extension Mock where O == Proposal {
  convenience init(
    body: String? = nil,
    choices: [String]? = nil,
    created: Int? = nil,
    id: String? = nil,
    ipfs: String? = nil,
    scores: [Double]? = nil,
    space: Mock<Space>? = nil,
    state: String? = nil,
    title: String? = nil
  ) {
    self.init()
    self.body = body
    self.choices = choices
    self.created = created
    self.id = id
    self.ipfs = ipfs
    self.scores = scores
    self.space = space
    self.state = state
    self.title = title
  }
}
