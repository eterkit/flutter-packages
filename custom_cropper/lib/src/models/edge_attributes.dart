// Flutter imports:
import 'package:flutter/material.dart';

/// Options to customize the edge style.
class EdgeAttributes {
  /// Default constructor for [EdgeAttributes].
  const EdgeAttributes({
    this.color = Colors.blue,
    this.size = 20,
  });

  /// Color of the edge point.
  ///
  /// **Default:** [Colors.blue]
  final Color color;

  /// Size of the edge point.
  ///
  /// **Default:** `20`.
  final double size;
}
