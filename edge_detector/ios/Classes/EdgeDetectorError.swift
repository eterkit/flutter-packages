public enum EdgeDetectorError {
    case missingArguments(FlutterMethodCall)
    case missingArgument(FlutterMethodCall, String)
    case fileNotFound(String)
    case detectionError(String)
    
    func toFlutterError() -> FlutterError {
        switch self {
        case .missingArguments(let call):
            return FlutterError(
                code: "missing-args",
                message: "Missing arguments",
                details: call.arguments
            )
        case .missingArgument(let call, let key):
            return FlutterError(
                code: "missing-arg",
                message: "Argument '\(key)' is missing",
                details: call.arguments
            )
        case .fileNotFound(let filePath):
            return FlutterError(
                code: "file-not-found",
                message: "Could not find image file under '\(filePath)' path",
                details: nil
            )
        case .detectionError(let details):
            return FlutterError(
                code: "detection-error",
                message: "Edge detector encountered a problem while detecting objects on MLKit side",
                details: details
            )
        }
    }
}
