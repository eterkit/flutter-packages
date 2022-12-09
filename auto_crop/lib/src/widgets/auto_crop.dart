import 'dart:io';

import 'package:custom_cropper/custom_cropper.dart';
import 'package:edge_detector/edge_detector.dart';
import 'package:flutter/material.dart';

/// Widget dedicated for image cropping.
/// Simply pass the [imageFile] and it will do all the magic for you.
///
/// Optionally you can pass [EdgeAttributes] to customize edge points,
/// [LineAttributes] to customize the lines between edges
/// & [OverlayAttributes] to customize the overlay outside the crop area.
class AutoCrop extends StatefulWidget {
  /// Creates [AutoCrop] widget from given [imageFile].
  const AutoCrop(
    this.imageFile, {
    super.key,
    required this.controller,
    this.edgeAttributes = const EdgeAttributes(),
    this.lineAttributes = const LineAttributes(),
    this.overlayAttributes = const OverlayAttributes(),
  });

  /// Crop controller is required to invoke crop methods from outside.
  final CropController controller;

  /// Image file to be displayed & cropped.
  final File imageFile;

  /// Provide edge visual attributes to customize style.
  ///
  /// **Default:** See [EdgeAttributes] for default values.
  final EdgeAttributes edgeAttributes;

  /// Provide overlay visual attributes to customize style.
  ///
  /// **Default:** See [LineAttributes] for default values.
  final LineAttributes lineAttributes;

  /// Provide overlay visual attributes to customize style.
  ///
  /// **Default:** See [OverlayAttributes] for default values.
  final OverlayAttributes overlayAttributes;

  @override
  State<AutoCrop> createState() => _AutoCropState();
}

class _AutoCropState extends State<AutoCrop> {
  Edges? _edges;

  @override
  void initState() {
    super.initState();
    _detectEdges();
  }

  @override
  Widget build(BuildContext context) {
    if (_edges == null) {
      return Image.file(
        widget.imageFile,
        fit: BoxFit.contain,
      );
    }
    return CustomCropper(
      widget.imageFile,
      controller: widget.controller,
      initialCorners: _edges?.values,
    );
  }

  Future<void> _detectEdges() async {
    final edges = await EdgeDetector().detectEdges(widget.imageFile);
    setState(() => _edges = edges);
  }
}
