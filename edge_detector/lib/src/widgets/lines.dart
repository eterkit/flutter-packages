import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:edge_detector/src/models/models.dart';

/// Widget that draws lines between [edges].
class Lines extends StatelessWidget {
  /// Default constructor for [Lines].
  const Lines(
    this.edges, {
    super.key,
    required this.lineAttributes,
  });

  /// Between this edges lines will be drawn.
  final List<Offset> edges;

  /// Options to customize the line style.
  final LineAttributes lineAttributes;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _LinesPainter(
        edges: edges,
        lineAttributes: lineAttributes,
      ),
    );
  }
}

class _LinesPainter extends CustomPainter {
  const _LinesPainter({
    required this.edges,
    required this.lineAttributes,
  });

  final List<Offset> edges;
  final LineAttributes lineAttributes;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..strokeWidth = lineAttributes.width
      ..strokeCap = StrokeCap.round
      ..color = lineAttributes.color.withOpacity(lineAttributes.colorOpacity);

    final points = <Offset>[...edges, edges[0]];
    canvas.drawPoints(PointMode.polygon, points, paint);
  }

  @override
  bool shouldRepaint(_) => false;
}
