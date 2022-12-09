# edge_detector

Edge detector plugin based on google ml kit object detection.
Allows basic edge detection for given image file.

#### :bulb: Please note that this package is just for edge detection. :bulb:
Please check other packages for cropping tools:
1. [auto_crop](https://github.com/eterkit/flutter-packages/tree/main/auto_crop) - available for Android & iOS only.
2. [custom_cropper](https://github.com/eterkit/flutter-packages/tree/main/custom_cropper)


## Preview
<img src="https://github.com/eterkit/flutter-packages/blob/main/edge_detector/example.gif?raw=true">

# Example usage

### Basic usage

```dart
Future<void> _detectEdges() async {
    final imageFile = File('path/to/image');
    // Edges that are respective for the original image size.
    final originalImageEdges = await EdgeDetector().detectEdges(imageFile);
    if (originalImageEdges == null) return;

    final topLeft = originalImageEdges.topLeft; // Offset(x,y).
    final topRight = originalImageEdges.topRight; // Offset(x,y).
    final bottomRight = originalImageEdges.bottomRight; // Offset(x,y).
    final bottomLeft = originalImageEdges.bottomLeft; // Offset(x,y).
    final all = originalImageEdges.values; // [topLeft, topRight, bottomRight, bottomLeft].

    // Edges that are respective for the rendered image widget size.
    final widgetEdges = await originalImageEdges.toWidgetEdges(
      imageKey: _imageKey,
      originalImageFile: imageFile,
    );
}
```

### Full example

Full example showing how to set up and use `EdgeDetector`. [Source code](https://github.com/eterkit/flutter-packages/tree/main/edge_detector/example)
