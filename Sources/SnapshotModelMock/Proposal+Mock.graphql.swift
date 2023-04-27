// @generated
// This file was automatically generated and should not be edited.

import ApolloTestSupport
import SnapshotModel

public class Proposal: MockObject {
  public static let objectType: Object = SnapshotModel.Objects.Proposal
  public static let _mockFields = MockFields()
  public typealias MockValueCollectionType = Array<Mock<Proposal>>

  public struct MockFields {
    @Field<[String?]>("choices") public var choices
    @Field<[Double?]>("scores") public var scores
    @Field<Space>("space") public var space
    @Field<String>("title") public var title
  }
}

public extension Mock where O == Proposal {
  convenience init(
    choices: [String]? = nil,
    scores: [Double]? = nil,
    space: Mock<Space>? = nil,
    title: String? = nil
  ) {
    self.init()
    self.choices = choices
    self.scores = scores
    self.space = space
    self.title = title
  }
}
