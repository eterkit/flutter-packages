import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:edge_detector/edge_detector.dart';

/// Widget dedicated for image cropping.
/// Simply pass the [imageFile] and it will do all the magic for you.
///
/// Optionally you can pass [EdgeAttributes] to customize edge points
/// & [LineAttributes] to customize the lines between edges.
class ImageCropper extends StatefulWidget {
  /// Creates [ImageCropper] widget from given [imageFile].
  const ImageCropper.file(
    this.imageFile, {
    super.key,
    this.edgeAttributes = const EdgeAttributes(),
    this.overlayAttributes = const LineAttributes(),
  });

  /// Image file to be displayed & cropped.
  final File imageFile;

  /// Provide edge visual attributes to customize style.
  ///
  /// **Default:** See [EdgeAttributes] for default values.
  final EdgeAttributes edgeAttributes;

  /// Provide overlay visual attributes to customize style.
  ///
  /// **Default:** See [LineAttributes] for default values.
  final LineAttributes overlayAttributes;

  @override
  State<ImageCropper> createState() => _ImageCropperState();
}

class _ImageCropperState extends State<ImageCropper> {
  static final GlobalKey _imageKey = GlobalKey();

  late Map<Corner, Offset> _points;
  late Offset _dragInitialPosition;

  Edges? _edges;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  @override
  void didUpdateWidget(covariant ImageCropper oldWidget) {
    super.didUpdateWidget(oldWidget);
    final shouldReInitialize = oldWidget.imageFile != widget.imageFile;
    if (shouldReInitialize) _initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        DragTarget(
          builder: (_, __, ___) => Image.file(
            key: _imageKey,
            widget.imageFile,
            fit: BoxFit.contain,
          ),
        ),
        if (_isInitialized) ...[
          Lines(
            _points.values.toList(growable: false),
            lineAttributes: widget.overlayAttributes,
          ),
          ..._points.keys.map((point) {
            final position = _points[point];
            if (position == null) return const SizedBox.shrink();
            return Positioned(
              left: position.dx - (widget.edgeAttributes.size / 2),
              top: position.dy - (widget.edgeAttributes.size / 2),
              child: Draggable<Offset>(
                onDragStarted: () => _dragInitialPosition = position,
                onDragUpdate: (details) => _onDragUpdate(point, details),
                onDragEnd: (details) => _onDragEnd(point, details),
                feedback: EdgeItem(
                  position,
                  edgeAttributes: widget.edgeAttributes,
                ),
                childWhenDragging: const SizedBox.shrink(),
                child: EdgeItem(
                  position,
                  edgeAttributes: widget.edgeAttributes,
                ),
              ),
            );
          }),
        ],
      ],
    );
  }

  Future<void> _initialize() async {
    setState(() => _isInitialized = false);
    await _detectEdges();
    await _initializePoints();
    setState(() => _isInitialized = true);
  }

  Future<void> _detectEdges() async {
    final edges = await EdgeDetector().detectEdges(widget.imageFile);
    if (edges == null) return;
    setState(() => _edges = edges);
  }

  Future<void> _initializePoints() async {
    final results = await Future.wait<Size>([
      _imageKey.maxSize,
      widget.imageFile.originalImageSize,
    ]);

    final renderedSize = results[0];
    final originalSize = results[1];

    const origin = Offset.zero;
    final edgeSize = widget.edgeAttributes.size;
    final edgeOffset = Offset(edgeSize, edgeSize);
    final negativeEdgeOffset = Offset(edgeSize, -edgeSize);
    final edges = _edges ??
        Edges(
          topLeft: originalSize.topLeft(origin) + edgeOffset,
          topRight: originalSize.topRight(origin) - negativeEdgeOffset,
          bottomRight: originalSize.bottomRight(origin) - edgeOffset,
          bottomLeft: originalSize.bottomLeft(origin) + negativeEdgeOffset,
        );

    _points = {
      Corner.topLeft: edges.topLeft *
          shorterSideFactor(
            renderedSize,
            originalSize,
          ),
      Corner.topRight: edges.topRight *
          shorterSideFactor(
            renderedSize,
            originalSize,
          ),
      Corner.bottomRight: edges.bottomRight *
          shorterSideFactor(
            renderedSize,
            originalSize,
          ),
      Corner.bottomLeft: edges.bottomLeft *
          shorterSideFactor(
            renderedSize,
            originalSize,
          ),
    };
  }

  void _onDragUpdate(Corner corner, DragUpdateDetails details) {
    final point = _points[corner];
    if (point == null) return;
    final newPosition = point + details.delta;
    setState(() => _points[corner] = newPosition);
  }

  void _onDragEnd(Corner corner, DraggableDetails details) {
    final isInBoundaries = details.wasAccepted;
    if (isInBoundaries) return;
    setState(() => _points[corner] = _dragInitialPosition);
  }
}
