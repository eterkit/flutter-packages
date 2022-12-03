import Flutter
import UIKit

public class SwiftEdgeDetectorPlugin: NSObject, FlutterPlugin {
    private static let channelName: String = "eterkit.com/edge_detector"
        private let detectEdgesMethod: String = "detectEdges"
    
    private let edgeDetector = EdgeDetector()
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: channelName, binaryMessenger: registrar.messenger())
        let instance = SwiftEdgeDetectorPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch (call.method) {
            case detectEdgesMethod:
                detectEdges(call, result)
            default:
                result(FlutterMethodNotImplemented)
        }
    }
    
    private func detectEdges(_ call: FlutterMethodCall,_ result: @escaping FlutterResult) {
        NSLog("Printable 1")
        // Ensure arguments exists and it's type is a Dictionary.
        guard let arguments = call.arguments as? [String: Any] else {
            result(EdgeDetectorError.missingArguments(call).toFlutterError())
            return
        }
        // Ensure the filePath argument exists and it's type is a String.
        guard let filePath = arguments["filePath"] as? String else {
            result(EdgeDetectorError.missingArgument(call, "filePath").toFlutterError())
            return
        }
        NSLog("Printable 2")
        edgeDetector.detectEdges(filePath: filePath, result: result)
    }
}
