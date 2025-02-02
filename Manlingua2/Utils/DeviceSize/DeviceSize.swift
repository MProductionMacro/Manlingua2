/*
import SwiftUI
import UIKit

struct DeviceSize {
    static let shared = DeviceSize()
    
    func getDeviceInfo() -> (width: CGFloat, height: CGFloat, deviceName: String, scale: CGFloat) {
        let screen = UIScreen.main.bounds
        let device = UIDevice.current
        
        var deviceName = "Unknown"
        if let simulatorModelIdentifier = ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] {
            deviceName = simulatorModelIdentifier
        } else {
            var systemInfo = utsname()
            uname(&systemInfo)
            let modelCode = withUnsafePointer(to: &systemInfo.machine) {
                $0.withMemoryRebound(to: CChar.self, capacity: 1) {
                    ptr in String(validatingUTF8: ptr)
                }
            }
            deviceName = modelCode ?? "Unknown Device"
        }
        
        return (
            width: screen.width,
            height: screen.height,
            deviceName: deviceName,
            scale: UIScreen.main.scale
        )
    }
    
    func displayDeviceInfo() -> String {
        let info = getDeviceInfo()
        let orientation = UIDevice.current.orientation.isPortrait ? "Portrait" : "Landscape"
        
        return """
        📱 Device Info:
        Device: \(info.deviceName)
        Width: \(String(format: "%.1f", info.width))
        Height: \(String(format: "%.1f", info.height))
        Scale: \(info.scale)x
        Orientation: \(orientation)
        """
    }
}
*/

