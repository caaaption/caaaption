import ComposableArchitecture
import XCTest

@testable import AppFeature

@MainActor
class AppDelegateTests: XCTestCase {
  func testAnalyticsEnabledForStaging() async {
    let store = TestStore(
      initialState: AppDelegateReducer.State(),
      reducer: AppDelegateReducer()
    )

    store.dependencies.build.bundleIdentifier = { "com.caaaption-staging" }
    store.dependencies.firebaseCore.configure = {}
    store.dependencies.analytics.setAnalyticsCollectionEnabled = { value in
      XCTAssertTrue(value)
    }

    let task = await store.send(.didFinishLaunching)
    await task.cancel()
  }

  func testAnalyticsDisabledForProduction() async {
    let store = TestStore(
      initialState: AppDelegateReducer.State(),
      reducer: AppDelegateReducer()
    )

    store.dependencies.build.bundleIdentifier = { "com.caaaption" }
    store.dependencies.firebaseCore.configure = {}
    store.dependencies.analytics.setAnalyticsCollectionEnabled = { value in
      XCTAssertFalse(value)
    }

    let task = await store.send(.didFinishLaunching)
    await task.cancel()
  }
}
