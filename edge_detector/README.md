# edge_detector

Edge detector plugin based on google ml kit object detection.
Allows basic edge detection and cropping for given image.

## Preview
<img src="https://github.com/eterkit/flutter-packages/blob/main/edge_detector/example.gif?raw=true">

# Example usage

### Basic usage

```dart
Future<void> _detectEdges() async {
    final imageFile = File('path/to/image');
    final edges = await EdgeDetector().detectEdges(imageFile);
    if (edges == null) return;

    final topLeft = edges.topLeft; // Offset(x,y).
    final topRight = edges.topRight; // Offset(x,y).
    final bottomRight = edges.bottomRight; // Offset(x,y).
    final bottomLeft = edges.bottomLeft; // Offset(x,y).
    final all = edges.values; // [topLeft, topRight, bottomRight, bottomLeft].
}
```

### Full example

Full example showing how to set up and use `EdgeDetector`.
[Source code](https://github.com/eterkit/flutter-packages/tree/main/edge_detector/example)
