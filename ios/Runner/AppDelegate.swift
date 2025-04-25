import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
    let iCloudChannel = FlutterMethodChannel(
      name: "com.jayjay.starter/icloud",
      binaryMessenger: controller.binaryMessenger
    )
    
    iCloudChannel.setMethodCallHandler { [weak self] (call: FlutterMethodCall, result: @escaping FlutterResult) in
      switch call.method {
      case "isICloudAvailable":
        result(ICloudService.shared.isICloudAvailable())
        
      case "syncToICloud":
        guard let args = call.arguments as? [String: Any],
              let filePath = args["filePath"] as? String else {
          result(false)
          return
        }
        result(ICloudService.shared.syncToICloud(filePath: filePath))
        
      case "restoreFromICloud":
        guard let args = call.arguments as? [String: Any],
              let destinationPath = args["destinationPath"] as? String else {
          result(false)
          return
        }
        result(ICloudService.shared.restoreFromICloud(destinationPath: destinationPath))
        
      default:
        result(FlutterMethodNotImplemented)
      }
    }
    
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
