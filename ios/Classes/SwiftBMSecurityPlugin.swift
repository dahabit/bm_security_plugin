import Flutter
import UIKit
import IOSSecuritySuite

public class SwiftBMSecurityPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "bm_security_plugin", binaryMessenger: registrar.messenger())
    let instance = SwiftBMSecurityPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
        case "deviceIsJailbroken":
            let deviceIsJailbroken = IOSSecuritySuite.amIJailbroken()
            result(deviceIsJailbroken)
            break
        default:
            result(FlutterMethodNotImplemented)
        }
  }
}
