public struct WrappedIdentifiable<T: Hashable>: Identifiable, Equatable {
  public var value: T
  public var id: Int {
    return value.hashValue
  }
  
  public init(value: T) {
    self.value = value
  }
}
