import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    
      let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
      let nativeChannel = FlutterMethodChannel(name: "native/sum", binaryMessenger: controller.binaryMessenger)
      
      nativeChannel.setMethodCallHandler({
          (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
          
          guard call.method == "sum" else {
              result(FlutterMethodNotImplemented)
              return
          }
          
          if let args = call.arguments as? [String: Any],
             let num1 = args["num1"] as? Int,
             let num2 = args["num2"] as? Int {
              result(num1 + num2)
          } else {
              result(-1)
          }
      })
      
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
