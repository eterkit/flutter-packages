import Flutter
import UIKit

public class HealthFlutterPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let healthApi = HealthApiService()
        HealthApiSetup.setUp(binaryMessenger: registrar.messenger(), api: healthApi)
    }
}
