// Dart imports:
import 'dart:async';
import 'dart:io';
import 'dart:ui';

// Flutter imports:
import 'package:flutter/services.dart';

/// Extension to get [Size] of the original [Image] from [File].
extension ImageSizeFromFileExtension on File {
  /// Returns [Size] of the original [Image] to which this [File] is pointing.
  Future<Size> get originalImageSize async {
    final data = await readAsBytes();
    final Completer<Image> completer = Completer();
    decodeImageFromList(Uint8List.view(data.buffer), completer.complete);
    final image = await completer.future;
    return Size(image.width.toDouble(), image.height.toDouble());
  }
}
