import AVFoundation
import SwiftUI

class CameraController: NSObject, ObservableObject {
   var captureSession: AVCaptureSession?
   private var photoOutput = AVCapturePhotoOutput()
   
   @Published var capturedImage: UIImage?
   @Published var isCameraActive = false
   @Published var hasCameraPermission = false
   
   static let shared = CameraController()
   
   var onCaptureComplete: ((UIImage) -> Void)?
   
   override init(){
      super.init()
      
      checkPermission()
   }
   
   func checkPermission() {
      let status = AVCaptureDevice.authorizationStatus(for: .video)
      
      switch status {
      case .notDetermined:
         // Request permission if status is not determined
         requestPermission()
      case .authorized:
         // If already authorized, set permission status to true
         hasCameraPermission = true
      case .denied, .restricted:
         // If denied or restricted, set permission status to false
         hasCameraPermission = false
          
      @unknown default:
         hasCameraPermission = false
      }
   }
   
   func requestPermission(){
      //print("MASUK ATAS")
      AVCaptureDevice.requestAccess(for: .video) { granted in
         //print("MASUK TENGAH")
         DispatchQueue.main.async {
            self.hasCameraPermission = granted
            //print(granted)
         }
      }
   }
   
   func startSession() {
      if captureSession == nil {
         configureSession()
      }
      
      DispatchQueue.global(qos: .userInitiated).async { [weak self] in
         self?.captureSession?.startRunning()
         
         // Update the isCameraActive property on the main thread
         DispatchQueue.main.async {
            self?.isCameraActive = true
         }
      }
   }
   
   func stopSession() {
      DispatchQueue.global(qos: .userInitiated).async { [weak self] in
         self?.captureSession?.stopRunning()
         
         // Update the isCameraActive property on the main thread
         DispatchQueue.main.async {
            self?.isCameraActive = false
         }
      }
   }
   
   private func configureSession() {
      let session = AVCaptureSession()
      session.sessionPreset = .photo
      
      guard let camera = AVCaptureDevice.default(for: .video),
            let input = try? AVCaptureDeviceInput(device: camera) else {
         print("Failed to access camera")
         return
      }
      
      if session.canAddInput(input) {
         session.addInput(input)
      }
      
      if session.canAddOutput(photoOutput) {
         session.addOutput(photoOutput)
      }
      
      captureSession = session
   }
   
   func capturePhoto() {
      let settings = AVCapturePhotoSettings()
      photoOutput.capturePhoto(with: settings, delegate: self)
   }
}

extension CameraController: AVCapturePhotoCaptureDelegate {
   func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
      guard let data = photo.fileDataRepresentation(),
            let image = UIImage(data: data) else {
         print("Error capturing photo")
         return
      }
      
      DispatchQueue.main.async {
         self.capturedImage = image
         self.onCaptureComplete?(image)
      }
   }
    
   func allowCameraAccess(){
       if let settingsUrl = URL(string: UIApplication.openSettingsURLString) {
          if UIApplication.shared.canOpenURL(settingsUrl) {
             UIApplication.shared.open(settingsUrl, options: [:], completionHandler: nil)
          }
       }
   }
}
