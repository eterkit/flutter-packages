import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';

import 'package:edge_detector/src/extensions/extensions.dart';
import 'package:edge_detector/src/models/models.dart';

/// Converter from original file [Edges] to rendered [Image] widget [Edges].
extension EdgesToWidgetEdgesExtension on Edges {
  /// Converts original file [Edges] to rendered [Image] widget [Edges].
  ///
  /// **NOTE:** The GlobalKey must be present in the widget tree.
  /// Otherwise it throws a [FlutterError].
  ///
  /// It automatically waits until the first frame is rendered to get size.
  /// So it can be used even before the build method in the same Widget class
  /// (for example in `initState`).
  Future<Edges> toWidgetEdges({
    required GlobalKey imageKey,
    required File originalImageFile,
  }) async {
    final results = await Future.wait<Size>([
      imageKey.maxSize,
      originalImageFile.originalImageSize,
    ]);

    final renderedSize = results[0];
    final originalSize = results[1];

    final edges = Edges(
      topLeft: topLeft * _shorterSideFactor(renderedSize, originalSize),
      topRight: topRight * _shorterSideFactor(renderedSize, originalSize),
      bottomRight: bottomRight * _shorterSideFactor(renderedSize, originalSize),
      bottomLeft: bottomLeft * _shorterSideFactor(renderedSize, originalSize),
    );
    return edges;
  }

  double _shorterSideFactor(Size smallerSize, Size biggerSize) {
    final widthFactor = smallerSize.width / biggerSize.width;
    final heightFactor = smallerSize.height / biggerSize.height;
    return min(widthFactor, heightFactor);
  }
}
