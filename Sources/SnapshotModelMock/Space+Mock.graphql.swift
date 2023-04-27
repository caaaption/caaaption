// @generated
// This file was automatically generated and should not be edited.

import ApolloTestSupport
import SnapshotModel

public class Space: MockObject {
  public static let objectType: Object = SnapshotModel.Objects.Space
  public static let _mockFields = MockFields()
  public typealias MockValueCollectionType = Array<Mock<Space>>

  public struct MockFields {
    @Field<String>("name") public var name
  }
}

public extension Mock where O == Space {
  convenience init(
    name: String? = nil
  ) {
    self.init()
    self.name = name
  }
}
