import 'package:flutter/material.dart';

/// Represents the farthest 4 points.
class Edges {
  /// Default constructor for [Edges].
  const Edges({
    required this.topLeft,
    required this.topRight,
    required this.bottomRight,
    required this.bottomLeft,
  });

  /// Factory constructor to create [Edges] from platform specific result.
  factory Edges.fromPlatformResult(Map<Object?, Object?> platformResult) {
    final left = (platformResult['left'] as int?)?.toDouble();
    final top = (platformResult['top'] as int?)?.toDouble();
    final right = (platformResult['right'] as int?)?.toDouble();
    final bottom = (platformResult['bottom'] as int?)?.toDouble();

    if (left == null || top == null || right == null || bottom == null) {
      throw StateError('Missing edges from detection result: $platformResult');
    }

    return Edges(
      topLeft: Offset(left, top),
      topRight: Offset(right, top),
      bottomRight: Offset(right, bottom),
      bottomLeft: Offset(left, bottom),
    );
  }

  /// The farthest point to the top and left.
  final Offset topLeft;

  /// The farthest point to the top and right.
  final Offset topRight;

  /// The farthest point to the bottom and right.
  final Offset bottomRight;

  /// The farthest point to the bottom and left.
  final Offset bottomLeft;

  /// Shortcut for all edge values in `List<Offset>`.
  List<Offset> get values => [topLeft, topRight, bottomRight, bottomLeft];
}
