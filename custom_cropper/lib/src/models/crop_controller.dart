// Dart imports:
import 'dart:typed_data';
import 'dart:ui';

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// Controller that helps invoking crop methods.
class CropController {
  /// Default constructor for [CropController].
  CropController({
    this.outputPixelRatio = 1,
  }) : cropperKey = GlobalKey();

  /// This key should be used in [RepaintBoundary].
  final GlobalKey cropperKey;

  /// The scale between the logical pixels and the size of the output image.
  /// For example: specifying `1.0` (the default) will give you a `1:1`
  /// mapping between logical pixels and the cropped output
  final double outputPixelRatio;

  /// Crops current image provided to `CustomCropper` widget,
  /// respecting the edges set by user.
  ///
  /// Returns `Uint8List` or null if cropping was unsuccessful.
  ///
  /// **NOTE**: You can save `Uint8List` to file like this:
  /// ```
  /// final data = cropController.cropImage();
  /// final file = await File('path/to/file').writeAsBytes(data.toList())
  /// ```
  Future<Uint8List?> crop() async {
    final boundary =
        cropperKey.currentContext?.findRenderObject() as RenderRepaintBoundary;
    final image = await boundary.toImage(pixelRatio: outputPixelRatio);

    final byteData = await image.toByteData(format: ImageByteFormat.png);
    return byteData?.buffer.asUint8List();
  }
}
