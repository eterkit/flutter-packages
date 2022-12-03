import 'dart:io';

import 'package:edge_detector/src/models/edges.dart';
import 'edge_detector_platform_interface.dart';

export 'src/extensions/extensions.dart';
export 'src/models/models.dart';
export 'src/utils/utils.dart';
export 'src/widgets/widgets.dart';

/// Base class for [EdgeDetector] plugin.
class EdgeDetector {
  /// Detects edges of given [imageFile]
  ///
  /// Returns [Edges] when succeeded or null on failure.
  ///
  /// **IMPORTANT**: Keep in mind that returned values will be
  /// respective to original image size. See `ImageCropper` widget to
  /// know how to convert and render [Edges] on the `Image` widget properly.
  Future<Edges?> detectEdges(File imageFile) {
    return EdgeDetectorPlatform.instance.detectEdges(imageFile);
  }
}
