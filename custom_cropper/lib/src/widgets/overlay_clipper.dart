// Flutter imports:
import 'package:flutter/rendering.dart';

// Project imports:
import 'package:custom_cropper/src/models/models.dart';

/// Clipper that crops the desired cut content.
class OverlayClipper extends CustomClipper<Path> {
  /// Default constructor for [OverlayClipper]
  const OverlayClipper({
    required this.edges,
    required this.overlayAttributes,
  });

  /// Edges that defines the polygon that is clipped.
  final List<Offset> edges;

  /// Options to customize the line style.
  final OverlayAttributes overlayAttributes;

  @override
  Path getClip(Size size) {
    final path = Path();
    path.addPolygon(edges, true);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
