// @generated
// This file was automatically generated and should not be edited.

import ApolloTestSupport
import SnapshotModel

public class Space: MockObject {
  public static let objectType: Object = SnapshotModel.Objects.Space
  public static let _mockFields = MockFields()
  public typealias MockValueCollectionType = Array<Mock<Space>>

  public struct MockFields {
    @Field<Int>("followersCount") public var followersCount
    @Field<String>("id") public var id
    @Field<String>("name") public var name
  }
}

public extension Mock where O == Space {
  convenience init(
    followersCount: Int? = nil,
    id: String? = nil,
    name: String? = nil
  ) {
    self.init()
    _set(followersCount, for: \.followersCount)
    _set(id, for: \.id)
    _set(name, for: \.name)
  }
}
