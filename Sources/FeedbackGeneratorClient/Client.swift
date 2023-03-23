public struct FeedbackGeneratorClient {
  public var selectionChanged: @Sendable () async -> Void
  public var impactOccurred: @Sendable () async -> Void
}
