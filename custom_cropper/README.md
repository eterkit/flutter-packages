# custom_cropper

Dart native image cropper package that allows cropping images 
with a custom and adjustable shape.

## Preview
<img src="https://github.com/eterkit/flutter-packages/blob/main/custom_cropper/example.gif?raw=true">

# Example usage

### Basic usage

```dart
Widget build(Build context) {
    ...
    // Define CustomCropper widget in the tree and pass the CropController.
    CustomCropper(
        imageFile,
        controller: _cropController,
    ),
    ...
    // Call crop method on CropController to get 
    // the cropped image result (Uint8List) data.
    ElevatedButton(
        onPressed: () async {
            final croppedData = await _cropController.crop();
        },
        child: const Text('Crop image'),
    ),
}
```

### Full example

Full example showing how to set up and use `EdgeDetector`. [Source code](https://github.com/eterkit/flutter-packages/tree/main/custom_cropper/example)
