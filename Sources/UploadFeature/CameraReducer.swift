import AVFoundation
import AVFoundationClient
import ComposableArchitecture
import SwiftUI

public struct CameraReducer: ReducerProtocol {
  public init() {}

  public struct State: Equatable {
    public let captureSession = AVCaptureSession()
    public var previewLayer: AVCaptureVideoPreviewLayer
    public var photoOutput = AVCapturePhotoOutput()

    public init() {
      captureSession.sessionPreset = .photo
      captureSession.beginConfiguration()
      previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
      previewLayer.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
    }
  }

  public enum Action: Equatable {
    case startSession
    case endSession
    case task
    case requestAccessResponse(TaskResult<Bool>)
  }

  @Dependency(\.avfoundationClient) var avfoundationClient

  public func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
    switch action {
    case .startSession:
      if !state.captureSession.isRunning {
        DispatchQueue.global(qos: .background).async { [session = state.captureSession] in
          session.startRunning()
        }
      }
      return EffectTask.none

    case .endSession:
      if state.captureSession.isRunning {
        state.captureSession.stopRunning()
      }
      return EffectTask.none

    case .task:
      return .task {
        await .requestAccessResponse(
          TaskResult {
            try await avfoundationClient.requestAccess(.video)
          }
        )
      }

    case let .requestAccessResponse(.success(result)):
      print(result)

      let device = AVCaptureDevice.default(for: AVMediaType.video)
      let deviceInput = try! AVCaptureDeviceInput(device: device!)
      state.captureSession.addInput(deviceInput)
      state.captureSession.commitConfiguration()

      return EffectTask.send(.startSession)

    case .requestAccessResponse(.failure):
      return EffectTask.none
    }
  }
}

public struct CameraView: View {
  let store: StoreOf<CameraReducer>

  public init(store: StoreOf<CameraReducer>) {
    self.store = store
  }

  struct ViewState: Equatable {
    public var previewLayer: AVCaptureVideoPreviewLayer

    public init(state: CameraReducer.State) {
      previewLayer = state.previewLayer
    }
  }

  public var body: some View {
    WithViewStore(store.scope(state: ViewState.init)) { viewStore in
      CALayerView(caLayer: viewStore.previewLayer)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onDisappear {
          viewStore.send(.endSession)
        }
        .task { await viewStore.send(.task).finish() }
    }
  }

  struct CALayerView: UIViewControllerRepresentable {
    var caLayer: CALayer

    func makeUIViewController(context: UIViewControllerRepresentableContext<CALayerView>) -> UIViewController {
      let viewController = UIViewController()

      viewController.view.layer.addSublayer(caLayer)
      caLayer.frame = viewController.view.frame

      return viewController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<CALayerView>) {
      caLayer.frame = uiViewController.view.frame
    }
  }
}
