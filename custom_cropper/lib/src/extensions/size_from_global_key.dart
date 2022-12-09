// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

/// Extension to convert [RenderBox] to [Size].
extension SizeFromGlobalKeyExtension on GlobalKey {
  /// Returns max [Size] of this [GlobalKey] object.
  ///
  /// **NOTE:** The GlobalKey must be present in the widget tree.
  /// Otherwise it throws a [FlutterError].
  ///
  /// It automatically waits until the first frame is rendered to get size.
  /// So it can be used even before the build method in the same Widget class
  /// (for example in `initState`).
  ///
  /// If you are sure that the widget is already
  /// present in the widget tree, use [maxSizeSync] synchronous method.
  Future<Size> get maxSize async {
    final Completer<RenderBox> completer = Completer();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final box = currentContext?.findRenderObject() as RenderBox?;
      if (box == null) throw FlutterError('Could not find RenderBox for $this');
      completer.complete(box);
    });
    final box = await completer.future;
    return Size(box.constraints.maxWidth, box.constraints.maxHeight);
  }

  /// Returns max [Size] of this [GlobalKey] object.
  ///
  /// **NOTE:** The GlobalKey must be present in the widget tree
  /// & the Widget itself has already been rendered.
  /// Otherwise it throws a [FlutterError].
  ///
  /// If you want to use this method in the same class before
  /// build method (for example in `initState`), use [maxSize] async method.
  /// It will automatically wait until the first frame is rendered to get size.
  Size get maxSizeSync {
    final box = currentContext?.findRenderObject() as RenderBox?;
    if (box == null) throw FlutterError('Could not find RenderBox for $this');
    return Size(box.constraints.maxWidth, box.constraints.maxHeight);
  }
}
