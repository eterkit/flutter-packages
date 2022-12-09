// Dart imports:
import 'dart:async';
import 'dart:io';

// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:custom_cropper/src/extensions/extensions.dart';
import 'package:custom_cropper/src/models/models.dart';
import 'package:custom_cropper/src/utils/utils.dart';
import 'package:custom_cropper/src/widgets/widgets.dart';

/// Widget dedicated for image cropping.
/// Simply pass the [imageFile] and it will do all the magic for you.
///
/// Optionally you can pass [EdgeAttributes] to customize edge points,
/// [LineAttributes] to customize the lines between edges
/// & [OverlayAttributes] to customize the overlay outside the crop area.
class CustomCropper extends StatefulWidget {
  /// Creates [CustomCropper] widget from given [imageFile].
  const CustomCropper(
    this.imageFile, {
    super.key,
    required this.controller,
    this.edgeAttributes = const EdgeAttributes(),
    this.lineAttributes = const LineAttributes(),
    this.overlayAttributes = const OverlayAttributes(),
    this.initialEdges,
  }) : assert(initialEdges == null || initialEdges.length == 4);

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

  /// (Optional) Initial edges.
  ///
  /// **IMPORTANT**: This should be the points that are respective
  /// for the **original** image size (**not** the rendered image size).
  /// List length must be equal to `4`.
  final List<Offset>? initialEdges;

  @override
  State<CustomCropper> createState() => _CustomCropperState();
}

class _CustomCropperState extends State<CustomCropper>
    with WidgetsBindingObserver {
  static final GlobalKey _imageKey = GlobalKey();

  late Orientation _currentOrientation;
  late Map<Corner, Offset> _points;
  late Offset _dragInitialPosition;

  late Size _originalSize;
  late Size _renderedSize;

  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initialize();

    WidgetsBinding.instance.addPostFrameCallback(
        (_) => _currentOrientation = MediaQuery.of(context).orientation);
  }

  @override
  void didChangeMetrics() {
    final orientation = MediaQuery.of(context).orientation;
    final didChangedOrientation = _currentOrientation != orientation;
    if (didChangedOrientation) _initialize();
    _currentOrientation = orientation;
  }

  @override
  void didUpdateWidget(covariant CustomCropper oldWidget) {
    super.didUpdateWidget(oldWidget);
    final shouldReInitialize = (oldWidget.imageFile != widget.imageFile) ||
        (oldWidget.initialEdges != widget.initialEdges);
    if (shouldReInitialize) _initialize();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                color: widget.overlayAttributes.color,
              ),
              child: Opacity(
                opacity: 1 - widget.overlayAttributes.opacity,
                child: Image.file(
                  key: _imageKey,
                  widget.imageFile,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            if (_isInitialized) ...[
              Lines(
                _points.values.toList(growable: false),
                lineAttributes: widget.lineAttributes,
              ),
              DragTarget(
                builder: (_, __, ___) => RepaintBoundary(
                  key: widget.controller.cropperKey,
                  child: ClipPath(
                    clipper: OverlayClipper(
                      edges: _points.values.toList(growable: false),
                      overlayAttributes: widget.overlayAttributes,
                    ),
                    child: Image.file(
                      widget.imageFile,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
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
        ),
      ],
    );
  }

  Future<void> _initialize() async {
    setState(() => _isInitialized = false);
    await _initializePoints();
    setState(() => _isInitialized = true);
  }

  Future<void> _initializePoints() async {
    final results = await Future.wait<Size>([
      _imageKey.maxSize,
      widget.imageFile.originalImageSize,
    ]);

    _renderedSize = results[0];
    _originalSize = results[1];

    const origin = Offset.zero;
    final edgeSize = widget.edgeAttributes.size;
    final edgeOffset = Offset(edgeSize, edgeSize);
    final negativeEdgeOffset = Offset(edgeSize, -edgeSize);
    final topLeft =
        widget.initialEdges?[0] ?? (_originalSize.topLeft(origin) + edgeOffset);
    final topRight = widget.initialEdges?[1] ??
        (_originalSize.topRight(origin) - negativeEdgeOffset);
    final bottomRight = widget.initialEdges?[2] ??
        (_originalSize.bottomRight(origin) - edgeOffset);
    final bottomLeft = widget.initialEdges?[3] ??
        (_originalSize.bottomLeft(origin) + negativeEdgeOffset);

    _points = {
      Corner.topLeft: topLeft *
          shorterSideFactor(
            _renderedSize,
            _originalSize,
          ),
      Corner.topRight: topRight *
          shorterSideFactor(
            _renderedSize,
            _originalSize,
          ),
      Corner.bottomRight: bottomRight *
          shorterSideFactor(
            _renderedSize,
            _originalSize,
          ),
      Corner.bottomLeft: bottomLeft *
          shorterSideFactor(
            _renderedSize,
            _originalSize,
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
