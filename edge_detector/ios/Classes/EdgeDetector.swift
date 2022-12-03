import Foundation
import MLKitObjectDetection
import MLKitVision

public class EdgeDetector {
    private static func options() -> ObjectDetectorOptions {
        let options = ObjectDetectorOptions()
        options.detectorMode = .singleImage
        return options
    }
    
    private let objectDetector = ObjectDetector.objectDetector(options: options())

    func detectEdges(filePath: String, result: @escaping FlutterResult) {
        guard let uiImage = UIImage(contentsOfFile: filePath) else {
            // File not found.
            result(EdgeDetectorError.fileNotFound(filePath))
            return
        }
        let image = VisionImage(image: uiImage)
        
        objectDetector.process(image) { detectedObjects, error in
            guard error == nil else {
                // Error encountered.
                result(EdgeDetectorError.detectionError(error.debugDescription))
                return
            }
            guard !(detectedObjects ?? []).isEmpty else {
                // No objects detected.
                result(nil)
                return
            }
            
            guard let object = detectedObjects?.first else { return }

            let detectedFrame = object.frame
            let edges = EdgeDetectorResult.fromFrame(frame: detectedFrame)
            result(edges.toJson())
        }
        
    }
}
