import SwiftUI
import AVFoundation

struct CameraPreview: UIViewControllerRepresentable {
   class PreviewViewController: UIViewController {
      var captureSession: AVCaptureSession?
      
      override func viewDidLoad() {
         super.viewDidLoad()
         
         if let captureSession = captureSession {
            let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            previewLayer.videoGravity = .resizeAspectFill
            previewLayer.frame = view.bounds
            view.layer.addSublayer(previewLayer)
         }
      }
      
      override func viewDidLayoutSubviews() {
         super.viewDidLayoutSubviews()
         view.layer.sublayers?.forEach { $0.frame = view.bounds }
      }
   }
   
   var captureSession: AVCaptureSession
   
   func makeUIViewController(context: Context) -> PreviewViewController {
      let viewController = PreviewViewController()
      viewController.captureSession = captureSession
      return viewController
   }
   
   func updateUIViewController(_ uiViewController: PreviewViewController, context: Context) {}
}
