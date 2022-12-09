import 'dart:ui';
import 'package:flutter/material.dart';

class Lines extends StatelessWidget {
  const Lines(
    this.edges, {
    super.key,
  });

  final List<Offset> edges;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _LinesPainter(edges: edges),
    );
  }
}

class _LinesPainter extends CustomPainter {
  const _LinesPainter({
    required this.edges,
  });

  final List<Offset> edges;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round
      ..color = Colors.blue;

    final points = <Offset>[...edges, edges[0]];
    canvas.drawPoints(PointMode.polygon, points, paint);
  }

  @override
  bool shouldRepaint(_) => false;
}
