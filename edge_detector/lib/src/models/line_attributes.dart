import 'package:flutter/material.dart';

/// Options to customize the line style.
class LineAttributes {
  /// Default constructor for [LineAttributes].
  const LineAttributes({
    this.color = Colors.blue,
    this.colorOpacity = 0.5,
    this.width = 2,
  });

  /// Color of the line.
  ///
  /// **Default: [Colors.blue]
  final Color color;

  /// Opacity of the overlay color. **Must be in range 0-1**.
  ///
  /// **Default:** `0.5`.
  final double colorOpacity;

  /// Width of the line.
  ///
  /// **Default: `2`.
  final double width;
}
