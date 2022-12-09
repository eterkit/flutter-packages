# auto_crop

Dart native image cropper package that allows cropping images 
with a custom and adjustable shape.

#### :bulb: Please note that the package is only for Android & iOS. :bulb:
For other platforms I recommend using: [custom_cropper](https://github.com/eterkit/flutter-packages/tree/main/custom_cropper) - dart native cropper.



## Preview
<img src="https://github.com/eterkit/flutter-packages/blob/main/custom_cropper/example.gif?raw=true">

# Example usage

### Basic usage

```dart
Widget build(Build context) {
    ...
    // Define AutoCrop widget in the tree and pass the CropController.
    AutoCrop(
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

Full example showing how to set up and use `AutoCrop`. [Source code](https://github.com/eterkit/flutter-packages/tree/main/auto_crop/example)
