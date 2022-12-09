// Flutter imports:
import 'package:flutter/material.dart';

/// Options to customize the crop overlay style.
class OverlayAttributes {
  /// Default constructor for [OverlayAttributes].
  const OverlayAttributes({
    this.color = Colors.black,
    this.opacity = 0.5,
  });

  /// Color of the overlay.
  ///
  /// **Default: [Colors.grey]
  final Color color;

  /// Opacity of the overlay color. **Must be in range 0-1**.
  ///
  /// **Default:** `0.5`.
  final double opacity;
}
