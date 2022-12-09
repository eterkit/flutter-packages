// Flutter imports:
import 'package:flutter/material.dart';

/// Options to customize the line style.
class LineAttributes {
  /// Default constructor for [LineAttributes].
  const LineAttributes({
    this.color = Colors.blue,
    this.width = 2,
  });

  /// Color of the line.
  ///
  /// **Default: [Colors.blue]
  final Color color;

  /// Width of the line.
  ///
  /// **Default: `2`.
  final double width;
}
