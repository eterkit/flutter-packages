import Foundation

struct EdgeDetectorResult {
    let left: CGFloat
    let top: CGFloat
    let right: CGFloat
    let bottom: CGFloat
    
    static func fromFrame(frame: CGRect) -> EdgeDetectorResult {
        return EdgeDetectorResult(
            left: frame.minX,
            top: frame.maxY,
            right: frame.maxX,
            bottom: frame.minY
        )
    }
    
    func toJson() -> Dictionary<String, Int> {
        return [
            "left": Int(left),
            "top": Int(top),
            "right": Int(right),
            "bottom": Int(bottom),
        ]
    }
}
